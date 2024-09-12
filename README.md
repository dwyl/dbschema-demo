# dbschema-demo

A small demo project to show how to use the `dbschema`
to explore the schema of a database
and generate [ERD](https://miro.com/diagramming/what-is-an-er-diagram/) diagrams.

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
*locally*.

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

#### 1. Install `DbSchema` CLIinde
