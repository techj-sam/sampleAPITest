package resources.features;

import com.intuit.karate.junit5.Karate;
import org.junit.jupiter.api.Test;

class UsersRunner {

   @Test
    Karate testUsers() {
        return Karate.run("users").relativeTo(getClass());
    }

//    @Karate.Test
//    Karate testEmployees(){
//            return Karate.run("employee","users").relativeTo(getClass());
//    }



}
