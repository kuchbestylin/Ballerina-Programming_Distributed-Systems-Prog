import ballerina/graphql;

service /lab3 on new graphql:Listener(1200) {
    private Student student;

    public function init(){
        self.student = new Student("323", "James Gosling");
    }

    resource function get student () returns Student {
        return self.student;
    }

    remote function more_courses(string course_code, float[] marks, float[] weights) returns error | Student{
        error? my_res = self.student -> setcourse(course_code,marks,weights);

        if my_res is error{
            return my_res;
        }
        else{
            return self.student;
        }
    }
}