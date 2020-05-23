package examples.users;

import com.intuit.karate.junit5.Karate;

class UsersRunner {

    @Karate.Test
    Karate testUsers() {
        return Karate.run("users").relativeTo(getClass());
    }

    @Karate.Test
    Karate testAll(){
        return Karate.run().relativeTo(getClass());
    }

//    @Karate.Test
//    Karate testEmployees(){
//            return Karate.run("employee","users").relativeTo(getClass());
//    }



}
