FROM --platform=linux/amd64 ubuntu:22.04

# Install JDK 17, OpenJFX, and other dependencies
RUN apt update -q && \
    apt install -y -q openjdk-17-jre openjdk-17-jdk-headless wget unzip libgl1-mesa-glx libgl1-mesa-dri

# Download and extract the JavaFX SDK (compatible with JDK 17 version)
RUN wget https://download2.gluonhq.com/openjfx/17.0.2/openjfx-17.0.2_linux-x64_bin-sdk.zip -O /tmp/openjfx.zip && \
    unzip /tmp/openjfx.zip -d /opt && \
    rm /tmp/openjfx.zip

# Set JavaFX environment variable for library path
ENV PATH_TO_FX=/opt/javafx-sdk-17.0.2/lib

# Set environment variables for DbSchema
ENV HOME=/home/dbschema
ENV USER=dbschema

# Create a non-root user
RUN useradd --create-home --home-dir "$HOME" "$USER"

# Copy DbSchema files to the container
COPY DbSchema $HOME/app
COPY openjfx-monocle-17.0.10.jar $HOME/dbs/lib/openjfx-monocle-17.0.10.jar
RUN chown -R "$USER:$USER" "$HOME/app"

# Copy Monocle jar to JavaFX lib directory
RUN cp $HOME/dbs/lib/openjfx-monocle-17.0.10.jar /opt/javafx-sdk-17.0.2/lib/

# Switch to non-root user
USER $USER

# Set the working directory
WORKDIR $HOME

# Copy an example Groovy script
COPY example_script.groovy $HOME/example_script.groovy

# Set the entry point to run DbSchema in headless mode with the example script
ENTRYPOINT ["java", "-Djava.awt.headless=true", "-Dglass.platform=Monocle", "-Dmonocle.platform=Headless", "-Dprism.order=sw", "-Dprism.verbose=true", "-Djavafx.platform=monocle", "--module-path", "/opt/javafx-sdk-17.0.2/lib", "--add-modules", "javafx.controls,javafx.base,javafx.graphics,javafx.swing", "--add-exports=javafx.graphics/com.sun.glass.ui=ALL-UNNAMED", "--add-exports=javafx.graphics/com.sun.javafx.util=ALL-UNNAMED", "--add-exports=javafx.graphics/com.sun.javafx.logging=ALL-UNNAMED", "--add-exports=javafx.base/com.sun.javafx.logging=ALL-UNNAMED", "-cp", "./app/lib/*:/opt/javafx-sdk-17.0.2/lib/openjfx-monocle-17.0.10.jar", "com.wisecoders.dbs.DbSchema", "-x", "./example_script.groovy"]