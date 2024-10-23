import com.wisecoders.dbs.schema.*
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.stream.Stream;


try {
    // Make sure to have the PostgreSQL driver
    com.wisecoders.dbs.cli.command.connectivity.DownloadDriverCommand.downloadDriver("PostgreSQL")

    // Create sample project
    Project project = new Project("sample", "PostgreSQL");

    // Create a connection to the PostgreSQL database
    //Connector con = ConnectorManager.createConnector("pg_con","PostgreSQL", "localhost", 5432, "org.postgresql.Driver", "postgres", "postgres")
    //String jdbcUrl = "jdbc:postgresql://" + System.getenv("DB_HOST") + ":" + System.getenv("DB_PORT") + "/" + System.getenv("DB_NAME")
    String jdbcUrl = "jdbc:postgresql://" + System.getenv("DB_HOST") + ":" + System.getenv("DB_PORT") + "/" + System.getenv("DB_NAME")
    Connector con = ConnectorManager.createConnector(
        "pg_con",
        "PostgreSQL",
        "org.postgresql.Driver",
        jdbcUrl,
        "postgres",
        "postgres"
    )
    con.importSchemes( project, "public")
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