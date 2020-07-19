package resources;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import com.intuit.karate.junit5.Karate;
import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;
import org.apache.commons.io.FileUtils;
import org.junit.jupiter.api.Test;

import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

class TestRunner {

    // this will run all *.feature files that exist in sub-directories
    // see https://github.com/intuit/karate#naming-conventions

    @Karate.Test
    Karate testAll() {
        return Karate.run().relativeTo(getClass());
    }


    @Test
    void testruninParallel() {
       Results results = Runner.parallel(getClass(), 1, "target/surefire-reports");
        generateReport(results.getReportDir());
        if (results.getFailCount()!=0){
            System.out.println( results.getErrorMessages());
        }
    }

    private static void generateReport(String reportDir) {
        Collection<File> jsonFiles = FileUtils.listFiles(new File(reportDir), new String[]{"json"}, false);
        List<String> jsonPaths = new ArrayList(jsonFiles.size());
        jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));
        Configuration config = new Configuration(new File("target"), "demo");
        ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
        reportBuilder.generateReports();
    }
}