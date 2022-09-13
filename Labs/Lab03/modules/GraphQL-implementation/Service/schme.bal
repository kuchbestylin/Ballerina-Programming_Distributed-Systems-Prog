distinct service class Student{
    private string student_number;
    private string name;
    private Course[] courses;

    public function init(string num, string name){
        self.student_number = num;
        self.name = name;
        self.courses = [];
    }

    resource function get stNumber() returns string {
        return self.student_number;
    }

    resource function get stName () returns string {
        return self.name;
    }

    resource function get courses () returns Course[] {
        return self.courses;
    }

    remote function setstNumber() returns string {
        return self.student_number;
    }

    remote function setstName () returns string {
        return self.name;
    }

    remote function setcourse (string code, float[] marks, float[] weights) returns error? {
        if marks.length() != weights.length(){
            return error("Error! there should be marks as weights");
        }
        else{
            self.courses.push(new Course(code,marks,weights));
        }
    }


}
distinct service class Course{
    private string course_code;
    private float[] marks;
    private float[] weights;

    public function init(string code, float[] marks, float[] weights){
        self.course_code = code;
        self.marks = marks;
        self.weights = weights;
    }

    resource function get code() returns string {
        return self.course_code;
    }

    resource function get marks() returns float[] {
        return self.marks;
    }

    resource function get weights() returns float[] {
        return self.weights;
    }
}