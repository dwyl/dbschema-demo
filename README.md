# dbschema-demo

A small demo project to show how to use the `dbschema`
to explore the schema of a database
and generate [ERD](https://miro.com/diagramming/what-is-an-er-diagram/) diagrams.

- [dbschema-demo](#dbschema-demo)
  - [What? 💭](#what-)
  - [Why? 🤷‍♀️](#why-️)
  - [Who? 👤](#who-)
  - [How? 🛠](#how-)
    - [Local schema visualization](#local-schema-visualization)
      - [1. Download and install `DbSchema`](#1-download-and-install-dbschema)
      - [2. Create database and create tables](#2-create-database-and-create-tables)
      - [3. Use `DbSchema` to visualize the schema](#3-use-dbschema-to-visualize-the-schema)
      - [4. Exporting HTML5 documentation](#4-exporting-html5-documentation)
    - [Headless schema visualization](#headless-schema-visualization)
      - [1. Automating downloading `DbSchema`'s installer](#1-automating-downloading-dbschemas-installer)
      - [2. Creating the `monocle.jar` file](#2-creating-the-monoclejar-file)
      - [3. Defining our `Docker` container](#3-defining-our-docker-container)
      - [4. Creating a `docker-compose.yml` file](#4-creating-a-docker-composeyml-file)
      - [5. Creating our `Groovy` script](#5-creating-our-groovy-script)
      - [6. Creating a `Github Actions` workflow and generating artifact](#6-creating-a-github-actions-workflow-and-generating-artifact)
- [Star this repo ⭐️](#star-this-repo-️)

## What? 💭

Visualizing the schema of a database is _essential_ for understanding its structure and relationships.
An Entity-Relationship Diagram (ERD) is a graphical representation of the database schema
that shows tables, columns, and relationships between them.
ERDs help developers, database administrators, and stakeholders **visualize the database design**,
identify potential issues, and optimize performance.

By using tools like `DbSchema`,
we can generate ERDs automatically from your database,
saving _time_ and _effort_ in documenting and analyzing the database schema,
facilitating onboarding and better comphrension of the database structure
amongst teams.

`DbSchema` allows you to help design and manage databases.
It has various features.
This tutorial, however, **is going to focus on visualizing the schema of a database**.

You can see the many features of `DbSchema`
at https://dbschema.com/features.html.

## Why? 🤷‍♀️

One of the many features `DbSchem` provides
is **the ability to generate HTML5 documentation of your database**.

Exporting **interactive HTML5 documentation** of your database serves several critical purposes.
HTML5 documentation is particularly beneficial because it offers a **web-friendly format**
that can be easily shared and embedded on the web.

This is _perfect_ for creating and maintaining up-to-date documentation,
thus ensuring that your database’s design and architecture are transparent and accessible,
facilitating better decision-making and collaboration. 🎉

## Who? 👤

This tutorial is specifically designed for technical writers
who are tasked with creating detailed and user-friendly documentation for database systems.

This guide will help you _speedrun_ the process of exporting HTML5 documentation using `DbSchema`
of an existing database,
and making it accessible through
**Github Actions**.

## How? 🛠

️Before proceeding,
make sure you have [**`PostgreSQL`**](https://www.postgresql.org/download/)
installed in your machine.

You can _optionally_ install [**`DBeaver`**](https://dbeaver.io/),
which will help you manage your databases and execute SQL queries
much easier.

### Local schema visualization

We'll first focus on running `DbSchema`
and generating the HTML5 documentation of a sample database
_locally_.

Afterwards,
we'll focus on running `DbSchema` headless.

#### 1. Download and install `DbSchema`

Let's start by downloading and installing `DbSchema`.
Go to https://dbschema.com/download.html
and download and install `DbSchema`.

Don't worry,
you don't need a license to follow this tutorial.
We will use the free version of `DbSchema`.
To unlock pro features,
we can use a 15-day trial.

After that,
open `DbSchema`.
You should see a screen like this:

<p align="center">
  <img width="800" src="https://github.com/user-attachments/assets/bcc3ded1-6166-4695-beb5-6fc4de39f239" />
</p>

Congratulations,
you have successfully installed `DbSchema`!

> [!NOTE]
>
> At the time of writing,
> we're using `DbSchema` version 9.6.2.

#### 2. Create database and create tables

Let's create a sample database and tables to visualize the schema.

Open your terminal and run the following commands:

```sh
psql -U postgres
```

You will now be in the `psql` shell.
Create a new database with any name.
For this tutorial, we will name it `"dbschema_demo"`.
Type this into the terminal.

```sql
CREATE DATABASE dbschema_demo;
```

Now, let's connect to the database.

```sh
\c dbschema_demo
```

Now, let's run a SQL script
to create some tables to visualize them!
`DbSchema`'s free trial has a cap of 12 tables
that we can generate an HTML5 page for.
Therefore, use a script that creates 12 tables.

To facilitate this process,
we have create one for you.
Save the script [`12_tables`](./12_tables.sql)
and run it!

```sh
\i /path/to/12_tables.sql
```

After this,
all the tables should be created!
You can now exist the `psql` interface
by running:

```sh
\q
```

#### 3. Use `DbSchema` to visualize the schema

Now that we have created the database and tables,
let's visualize the schema using `DbSchema`.

Open `DbSchema` and click on the `Connect to Database` button.

<p align="center">
  <img width="800" src="https://github.com/user-attachments/assets/4797f73f-2c06-4989-a0d5-853332d816e2" />
</p>

Follow the wizard.
Choose `PostgreSQL` as the database type
and enter the connection details.

<p align="center">
  <img width="45%" src="https://github.com/user-attachments/assets/02df4fd5-674f-465d-9f77-62f6365d9fed" />
  <img width="45%" src="https://github.com/user-attachments/assets/0b21925d-838b-4519-b28d-8409b7c5044e" />
</p>

Click on `Connect`.
You will be asked which schema you want to visualize.
Choose the default `public` schema.

<p align="center">
  <img width="800" src="https://github.com/user-attachments/assets/e22428ee-c74e-4102-b631-0cc724411d69" />
</p>

And you're in!
You will see the tables in a diagram.

<p align="center">
  <img width="800" src="https://github.com/user-attachments/assets/e71482ca-0b6c-4404-bb64-b4d879f602ab" />
</p>

#### 4. Exporting HTML5 documentation

To export an HTML5 page,
go over to `Model > Export As ... > Generate HTML5/PDF Documentation`.

<p align="center">
  <img width="800" src="https://github.com/user-attachments/assets/3b2facf3-f660-487e-8ae3-8e09c6f7948d" />
</p>

You can leave the settings on
(or customize to your liking)
and select a path to save the HTML page.
Click on `Generate`.

<p align="center">
  <img width="800" src="https://github.com/user-attachments/assets/652f18f8-6ed3-4405-b9c6-dbc6e4f24706" />
</p>

And you're done!
You have successfully exported the HTML5 documentation of your database! 🎉
You can open your HTML page in a browser
and interact with the schema.
You can see the details of the diagram,
of the tables and columns,
and the relationships between them.

<p align="center">
  <img width="800" src="https://github.com/user-attachments/assets/652f18f8-6ed3-4405-b9c6-dbc6e4f24706" />
</p>

Hurray! 🥳

### Headless schema visualization

Now that we have seen how to visualize the schema of a database
through `DbSchema`'s GUI,
let's see how we can do this **headlessly**.

This is particularly useful when you want to automate the process
of generating HTML5 documentation of your database
and make it accessible through `Github Actions`.

In this section, we're going to focus

#### 1. Automating downloading `DbSchema`'s installer

To run `DbSchema` headlessly,
we are going to need the installer.
You can find the the installers for different OS
in https://dbschema.com/download.html.

In our case,
we are going to make use of `Docker` to run the installer
and run it in a `Linux`-based system inside a container.

Let's first automate the downloading of the installer.
We are going to create a [`Makefile`](https://opensource.com/article/18/8/what-how-makefile)
to help us do this.
Create a file called `Makefile` and use the following content:

```makefile
# Define variables
DOCKERUSER = userino

MAJOR = 9
MINOR = 6
PATCH = 3

DBSCHEMA_TAR = dbschema_$(MAJOR)_$(MINOR)_$(PATCH).tar.gz
DBSCHEMA_URL = https://www.dbschema.com/download/DbSchema_unix_$(MAJOR)_$(MINOR)_$(PATCH).tar.gz

# Default target
all: download extract

# Download the DbSchema `tar.gz` file if it doesn't exist
download:
	if [ ! -f $(DBSCHEMA_TAR) ]; then \
		curl -L $(DBSCHEMA_URL) --output $(DBSCHEMA_TAR); \
	fi

# Extract the downloaded `tar.gz` file
extract: $(DBSCHEMA_TAR)
	tar xvf $(DBSCHEMA_TAR)

# Clean up downloaded files (optional)
clean:
	rm -f $(DBSCHEMA_TAR)
	rm -rf DbSchema

.PHONY: all download extract clean
```

We are defining a few variables first that are going to be used:

- `DOCKERUSER = userino`:
  Defines the Docker user.
- `MAJOR = 9`, `MINOR = 6`, `PATCH = 3:`
  Defines version numbers for DbSchema.
- `DBSCHEMA_TAR = dbschema_$(MAJOR)_$(MINOR)_$(PATCH).tar.gz`:
  Constructs the `tar` file name using the version numbers.
- `DBSCHEMA_URL = https://www.dbschema.com/download/DbSchema_unix_$(MAJOR)_$(MINOR)_$(PATCH).tar.gz`:
  Constructs the download URL using the version numbers.
  It uses the download URL for Unix-based systems
  that was mentioned before.

We are also defining a **default target** `all` that runs `download` and `extract`.
These two methods check if the `tar` file does not exist
and downloads it using `curl` if necessary.
Then, it extracts the `tar` file,
respectively.

We've also defined a `clean` target that removes the downloaded files.

Here how the flow looks like
when you run the command `make`.

- When `make` is run,
  it triggers the `all` target.
- The `all` target depends on `download` and `extract`.
- The `download` target checks for the existence of the tar file and downloads it if it doesn't exist.
- The `extract` target extracts the contents of the tar file.
- Optionally, the `clean` target can be run to remove the downloaded and extracted files.

With this,
we can always download and extract the latest version of `DbSchema`
by just running `make`! 🎉

#### 2. Creating the `monocle.jar` file

According to https://dbschema.com/documentation/dbschemacli.html#docker,
we need to **create a `monocle.jar` file and place it in the `lib` directory of `DbSchema`**
if we want to run `DbSchema` in headless mode.

To create the `monocle.jar` file,
we have two options.
In either of them,
we need to build it in the correct Java `JDK` version,
which in our case, it's `JDK 17`.

- head over to https://github.com/TestFX/Monocle
  and follow the instructions
  and _build the `monocle.jar`_ file
  for `JDK 17`.
- download the `monocle.jar` file from `Maven` repository
  in https://central.sonatype.com/artifact/org.testfx/openjfx-monocle/17.0.10.

In our case,
we went with the first option
and the resulting `monocle.jar` file
is available in this repository,
called **`openjfx-monocle-17.0.10.jar`**.

We are going to be using this file within the `Docker` container,
in the following section.
This is because, according to the
[`DbSchema` documentation](https://dbschema.com/documentation/dbschemacli.html#docker),
we need to place it in the `lib` directory of `DbSchema` installer files
(after extraction).

#### 3. Defining our `Docker` container

Now that we have the installer,
we are going to need it to install it and run `DbSchema` headlessly.
**We are going to be executing it inside a `Docker` container running `Linux`.**

With this in mind,
in the same directory as the `Makefile`,
let's create a `Dockerfile` with the following content:

```Dockerfile
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
```

Let's break down what's happening in the `Dockerfile`:

- We specify the base image as `Ubuntu 22.04` for the `AMD64 architecture`.
  This is better for compatibility with `DbSchema`.
  It then updates the package list and installs `JDK 17`, `OpenJFX`, and other necessary dependencies such as `wget`, `unzip`, and `PostgreSQL` client.
  These dependencies _are crucial_ for running `DbSchema` headlessly
  and to run the rest of the commands ahead!
  Because `DbSchema` implements `JDK v17` and `OpenJFX` for its GUI,
  we need to install these dependencies to run it headlessly.

- Next, it downloads the `JavaFX` SDK compatible with `JDK 17` and
  extracts it to the `/opt directory`.
  `JavaFX` is used by `DbSchema` and it fails if we don't install it and define the environment variables correctly,
  hence why setting up the `PATH_TO_FX` env variable.

- In addition to this,
  we are copying the `monocle.jar` file
  we've created in the previous section.
  This file goes into the `lib` directory
  of the extracted `DbSchema` installer,
  as defined in `DbSchema`'s documentation.

- The working directory is set to `/home/dbschema`.
  Afterwards, `DbSchema` installer files, `Monocle` jar file,
  and an example `Groovy` script are copied to the container.
  This `Groovy` script is what we are going to automate tasks
  and interact with `DbSchema` without having to use the GUI.
  You can find more information in https://dbschema.com/documentation/automation-api.html.

- Next, we create a small shell script to run `DbSchema` in headless mode.
  This script only exists so that the container exits with the correct exit code.
  For example, if `DbSchema` running the `Groovy` script fails,
  the shell script fails too.
  This is important in the context of `Github Actions`,
  where we want to know if the process failed or not.

- Finally,
  the created shell script is set as the entry point for the container.

> [!NOTE]
>
> Do note that we haven't created a non-root user in the `Docker` container.
> This is because we found out that when running this in `Github Actions`,
> it was causing permission issues when generating files when executing the script.
>
> Therefore, we are running the `DbSchema` Java process as `root`.

Awesome! 🎉

We are now really close to running an instance of `DbSchema` in headless mode!

However, we are missing one thing:
the `example_script.groovy` file that we are going to use!

Let's go over that now.

#### 4. Creating a `docker-compose.yml` file

We are going to use `Docker Compose` to run the `Docker` container
we've created above.
This container will run `DbSchema`,
which in turn,
will run a `Groovy` script that will generate the HTML5 documentation of the database.

`DbSchema` _will need to connect to a PostgreSQL database_ inside the `Groovy` script.
Therefore, we will need to define _another `Docker` container_ that runs a `PostgreSQL` database.

Create a `docker-compose.yml` file with the following content:

```yaml
# Run `sudo docker compose up --build` to build and start the services

services:
  # PostgreSQL database service
  postgres-db:
    image: postgres:14
    environment:
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: postgres
      POSTGRES_DB: postgres
    ports:
      - "5432:5432"
    healthcheck:
      test: ["CMD-SHELL", "psql -h localhost -p 5432 -U postgres -d postgres -c '\\q'"] # Check if the database is ready
      interval: 3s
      timeout: 5s
      retries: 5
    volumes:
      - postgres-data:/var/lib/postgresql/data
      - ./12_tables.sql:/docker-entrypoint-initdb.d/12_tables.sql
    networks:
      - my-network

  # DbSchema service
  app:
    build: .
    depends_on:
      postgres-db:
        condition: service_healthy
    networks:
      - my-network
    environment:
      DB_HOST: postgres-db
      DB_USER: postgres
      DB_PASSWORD: postgres
      DB_NAME: postgres
      DB_PORT: 5432
      OUTPUT_PATH: /tmp/output
    volumes:
      - ./output:/tmp/output # Mount the output directory.

volumes:
  postgres-data:

networks:
  my-network:
```

Let's break this down:

- in the **`postgres-db`** service,
  we are defining the `PostgreSQL` database container.

  - It uses the `PostgreSQL 14` image.
  - We define the database, user and password as environment variables.
  - We expose the `5432` port, which is the default `PostgreSQL` port.
  - We define a health check to ensure the database is ready.
    This health check will be used by the other service (running the `Dockerfile` image we've created earlier)
    to ensure the database is ready before running the `DbSchema` script.
    For this, we use the `psql` command to check if we can connect to the database.
  - We mount the `postgres-data` volume to persist the database data.
    In addition to this, we mount the **[`12_tables.sql`](./12_tables.sql) file to the `/docker-entrypoint-initdb.d` directory**.
    This `12_tables.sql` file will be used to create the tables in the database as an example.
    We map this script to the `docker-entrypoint-initdb.d` directory inside the container,
    which is used by [`PostgreSQL` to run scripts when the container starts.](https://yes-we-can-devops.hashnode.dev/docker-entrypoint-initdbd)

- in the **`app`** service,
  we run the `Dockerfile` image we've defined earlier.

  - We define a dependency on the `postgres-db` service.
    This dependency ensures that the `DbSchema` service only starts when the `PostgreSQL` database is ready.
  - We define the environment variables that the `DbSchema` script will use to connect to the database.
    These env variables will be used in the `Groovy` script.
  - We mount the `output` directory to `/tmp/output` inside the container.
    This will create an `output` directory _on our local machine_
    that contains everything that is inside the `/tmp/output` directory _inside the container_.
    Within the container,
    we will generate the HTML5 documentation page inside `/tmp/output`.

- both of these services run within the same `my-network` network,
  so they are able to communicate with each other.

And that's it!
If we run `sudo docker compose up --build`,
both the images will be built and the services will start running.
`postgres-db` will start first,
while `app` waits for it.
Once `postgres-db` is ready,
app will start running the `DbSchema` script,
and exits if it's executed successfully.

You can check the `output` directory
to see the generated HTML5 documentation page!

All that's left now is to create the `Groovy` script.
Let's crack on with that! 🏃‍♂️

#### 5. Creating our `Groovy` script

> [!IMPORTANT]
>
> `DbSchema`'s docs have some documentation on these scripts
> so you can know what features you can automate.
> Check https://dbschema.com/documentation/automation-api.html for more information.
>
> In addition to this,
> you have access to [**`DbSchema API` documentation**](https://dbschema.com/documentation/automation-api.html),
> which provides a list of classes and methods you can use in your scripts.

`DbSchema` provides us with some example of scripts
so that we can dip our toes into the automation process.
In conjunction with the [`DbSchema API`](https://dbschema.com/documentation/automation-api.html),
we can create scripts that automate tasks
and interact with `DbSchema` and do all sorts of stuff!

You can explore some scripts by opening the `DbSchema` GUI,
go to `Tools > Automation Scripts`,
and peruse the scripts available.

<p align="center">
  <img width="45%" src="https://github.com/user-attachments/assets/f3a2b9fb-9624-4922-bc73-ffa816524ad9">
  <img width="45%" src="https://github.com/user-attachments/assets/fff74e3b-bada-4f72-beee-da7417439a8b">
</p>

For this tutorial,
we are going to create a script that will generate
[an HTML5 documentation page](https://dbschema.com/documentation/schema-documentation.html).
This page will have a diagram with all the tables of the database,
where we can customize this layout fully.

Create a file called `example_script.groovy` with the following content:

```groovy
import com.wisecoders.dbs.diagram.model.Callout
import com.wisecoders.dbs.diagram.model.Depict
import com.wisecoders.dbs.diagram.model.Group
import com.wisecoders.dbs.diagram.model.Point
import com.wisecoders.dbs.schema.*
import javafx.scene.paint.Color

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.stream.Stream;

// Connection parameters
def conn_alias = "pg"
def conn_dbmsName = "PostgreSQL"
def conn_driver = "org.postgresql.Driver"
def conn_jdbcUrl = "jdbc:postgresql://" + System.getenv("DB_HOST") + ":" + System.getenv("DB_PORT") + "/" + System.getenv("DB_NAME")
def conn_username = "postgres"
def conn_password = "postgres"

// Color maps according to table prefixes
def backgroundColorMap = [
        "dim" :"#c4e0f9",
        "fact" :"#feea9b",
]

def foregroundColorMap = [
        "dim" :"#96c8f4",
        "fact" :"#fddf69",
]


try {
    // Make sure to have the PostgreSQL driver
    com.wisecoders.dbs.cli.command.connectivity.DownloadDriverCommand.downloadDriver(conn_dbmsName)

    // Create sample project
    Project project = new Project("sample", conn_dbmsName);

    // Create a connection to the PostgreSQL database
    Connector con = ConnectorManager.createConnector(
        conn_alias,
        conn_dbmsName,
        conn_driver,
        conn_jdbcUrl,
        conn_username,
        conn_password
    )

    // Import "public" schema
    def dbSchema = "public"
    Schema schema = con.importSchema(project, dbSchema)
    println "processing schema: ${schema}"

    // Creating layout and groups
    Layout layout = project.createLayout("ERD-${schema}")
    def grps = ["defaultKey": null]

    // Create layout in the project. We are creating a single one.
    // See https://dbschema.com/documentation/layouts.html for more information,
    for (Table table: schema.tables){

        // We expect all table name to have a "dim_" or "fact_" prefix
        String tableType = table.getName().split('_')[0]
        table.setComment("COMMENT ON TABLE ${table.getName()}")
        bgColor = backgroundColorMap.get(tableType)
        fgColor = foregroundColorMap.get(tableType)

        if(!grps.containsKey(tableType)){
            Group grp = layout.diagram.createGroup(tableType)
            grps.put(tableType, grp)
            println "Add layout group for domain ${tableType}"
        }

        // Create depict for the table
        Depict depict = layout.attach( table )
        depict.setComment("COMMENT STRING")
        //depict.hideColumnsIfDepictIsLarge()

        // Get the group and attach the depict to the group and setting its color
        grp = grps.get(tableType)

        grp.attachDepict( depict )
        grp.setColor(Color.web(bgColor))
        println "Add table ${table}"
    }
    layout.autoArrange()

    // Export HTML5 documentation
    def outputDir = new File(System.getenv("OUTPUT_PATH"))
    def outputFile = outputDir.getPath() + "/erd_" + dbSchema.toLowerCase() + ".html"

    // Create the output directory in case it doesn't exist
    if (!outputDir.exists()) {
        outputDir.mkdirs()
    }

    println "general html file: ${outputFile}"
    htmlFile = new File(outputFile)
    layout.generateHtmlDocumentation( htmlFile, [layout] )
}

// Ensure the script exits with a non-zero status on failure
catch (Exception e) {
    println "Script failed: ${e.message}"
    e.printStackTrace()
    System.exit(1)
}

// Explicitly exit with 0 if the script succeeds
System.exit(0)
```

> [!NOTE]
>
> We recommend you read the [`DbSchema API`](https://dbschema.com/documentation/automation-api.html)
> in tandem with this script to understand what each method does.

This script connects to a `PostgreSQL` database and generates an _ERD (Entity-Relationship Diagram)_
with color-coded tables based on their prefixes.
If we check `12_tables.sql` file,
we can see that the tables have prefixes `dim_` and `fact_`,
for [dimension and facts tables](https://www.databricks.com/glossary/star-schema), respectively.

Before starting, we import necessary libraries
and **define connection parameters using environment variables**
for the database.
We initialize the needed parameters to _connect to the database_,
including `alias`, the `dbmsName` (which must be the same as defined by `DbSchema`),
the `driver` used,
the `jdbcUrl` to connect to the database,
the database `username` and `password`.
Additionally, some color maps are defined for table prefixes.

- The script starts by downloading the `PostgreSQL` driver if it's not already available.
- A new project is created,
  and a connection to the `PostgreSQL` database is established using the provided connection parameters.
- After, we import the `"public"` schema from the database and create a layout for the ERD.
- We iterate over the tables in the schema,
  assigning colors and comments based on their prefixes,
  and group them accordingly.
- the layout is then auto-arranged,
  and `HTML5` documentation is generated and saved to a specified '`output`' directory.

If any errors occur during the process,
the script catches the exception,
prints an error message,
and exits with a non-zero status.
If the script completes successfully, it exits with a status of `0`.

We make use of the environment variables defined in the `docker-compose.yml` file
to create the connection and output paths.

#### 6. Creating a `Github Actions` workflow and generating artifact

Now we have all we need to run `DbSchema` headlessly
and generate the HTML5 documentation of the database
**inside a Github Actions workflow**.
We will be generating an artifact,
which will contain the HTML5 documentation page.

Create your workflow file (e.g.: `generate_html.yml`) in the `.github/workflows` directory:

```yaml
name: DbSchema Workflow

on: [push]

jobs:
  dbschema-job:
    runs-on: ubuntu-22.04

    steps:
    - name: Checkout code
      uses: actions/checkout@v4

    - name: Install Make
      run: sudo apt-get install -y make

    - name: Run Makefile
      run: make

    - name: Build and Run Docker Compose
      run: |
        # Run Docker Compose in detached mode
        sudo docker compose up --build --exit-code-from app

    - name: Upload Artifacts
      uses: actions/upload-artifact@v4
      with:
        name: dbschema-html-output
        path: output/*

```

As you can see, it's really simple!
We've done all the work inside the `Docker` containers
in conjunction with the `docker-compose.yml` file.
The `Github Actions` workflow file is just a few steps:

- checking out the code.
- installing `Make`.
- running the `Makefile` to download and extract the `DbSchema` installer.
- building and running the `Docker Compose` services.
- uploading the `output` directory as an artifact.

And that's it!
If you push your code to the repository,
the `Github Actions` workflow will run,
and you will have an artifact with the HTML5 documentation page.

<p align="center">
  <img width="800" src="https://github.com/user-attachments/assets/486f4377-18d8-474c-8355-dfb49d6addcc">
</p>

Great job!
Give yourself a pat on the back! ✌️

# Star this repo ⭐️

If this was useful to you, give it a star! 😉
