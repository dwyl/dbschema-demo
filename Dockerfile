FROM --platform=linux/amd64 ubuntu:22.04

# Install JDK 17, OpenJFX, and other dependencies
RUN apt update -q && \
    apt install -y -q openjdk-17-jre openjdk-17-jdk-headless wget unzip libgl1-mesa-glx libgl1-mesa-dri postgresql-client

# Download and extract the JavaFX SDK (compatible with JDK 17 version, required by DbSchema)
RUN wget https://download2.gluonhq.com/openjfx/17.0.2/openjfx-17.0.2_linux-x64_bin-sdk.zip -O /tmp/openjfx.zip && \
    unzip /tmp/openjfx.zip -d /opt && \
    rm /tmp/openjfx.zip

# Set JavaFX environment variable for library path and copy Monocle jar to JavaFX lib directory
ENV PATH_TO_FX=/opt/javafx-sdk-17.0.2/lib
COPY openjfx-monocle-17.0.10.jar $PATH_TO_FX/

# Set work directory to `/home/dbschema` - DbSchema's home directory
WORKDIR /home/dbschema

# Copy DbSchema installer files to the container
# Copy the monocle jar to the lib directory (as per https://dbschema.com/documentation/dbschemacli.html#docker)
# Copy the example script to the current directory
COPY DbSchema ./app
COPY openjfx-monocle-17.0.10.jar ./app/lib/openjfx-monocle-17.0.10.jar
COPY example_script.groovy .

# Create a simple script that runs DbSchema and propagates the exit code.
# This is done to ensure that the container exits with the correct exit code (if the script fails, the container should fail too).
RUN echo '#!/bin/sh\n' \
    'set -e\n' \
    'java -Djava.awt.headless=true -Dglass.platform=Monocle -Dmonocle.platform=Headless -Dprism.order=sw -Djavafx.platform=monocle --module-path /opt/javafx-sdk-17.0.2/lib --add-modules javafx.controls,javafx.base,javafx.graphics,javafx.swing --add-exports=javafx.graphics/com.sun.glass.ui=ALL-UNNAMED --add-exports=javafx.graphics/com.sun.javafx.util=ALL-UNNAMED --add-exports=javafx.graphics/com.sun.javafx.logging=ALL-UNNAMED --add-exports=javafx.base/com.sun.javafx.logging=ALL-UNNAMED -cp ./app/lib/*:/opt/javafx-sdk-17.0.2/lib/openjfx-monocle-17.0.10.jar com.wisecoders.dbs.DbSchema -x  ./example_script.groovy\n' \
    'EXIT_CODE=$?\n' \
    'if [ $EXIT_CODE -ne 0 ]; then\n' \
    '  echo "Script execution failed with exit code $EXIT_CODE."\n' \
    '  exit $EXIT_CODE\n' \
    'else\n' \
    '  echo "Script executed successfully."\n' \
    '  exit 0\n' \
    'fi' > /home/dbschema/run_dbschema.sh

# Run the script as the entry point
ENTRYPOINT ["sh", "/home/dbschema/run_dbschema.sh"]

# Uncomment to keep the container running after the script execution
#RUN sh /home/dbschema/run_dbschema.sh || true
#CMD ["tail", "-f", "/dev/null"]
