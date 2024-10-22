import com.wisecoders.dbs.schema.*
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.stream.Stream;


try {

    String userHome = System.getProperty("user.home");
    Path homePath = Paths.get(userHome).resolve("/.DbSchema/drivers/PostgreSQL");

    try (Stream paths = Files.list(homePath)) {
    paths.filter(Files::isRegularFile).forEach(System.out::println);
    } catch (IOException e) {
    e.printStackTrace();
    }

    Project proj = new Project("sample", "SqlServer");
    println "Project " + proj.getName()

    Connector con = ConnectorManager.createConnector("pg_con","testdb", "localhost", 5432, "org.postgresql.Driver", "postgres", "postgres")
    // HERE SPECIFY THE CONNECTION PASSWORD
    con.setPassword("postgres")

    con.importSchemes( proj, "public")
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