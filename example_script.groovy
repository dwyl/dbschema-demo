import com.wisecoders.dbs.schema.*
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

    // Import schemes
    con.importSchemes( project, "public")

    // Print schemas and tables
    for( Schema sch : project.schemas ){
        out.println( "Schema " + sch.getNameWithCatalog() )
        for ( Table table : sch.tables ){
            out.println( "  Table " + table.getName() )
        }
    }
} 

// Ensure the script exits with a non-zero status on failure
catch (Exception e) {
    println "Script failed: ${e.message}"
    e.printStackTrace()
    System.exit(1)  
}

// Explicitly exit with 0 if the script succeeds
System.exit(0)