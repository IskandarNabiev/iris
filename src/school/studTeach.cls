Class School.studTeach Extends %Persistent
{

Property student As School.Student;

Property teacher As School.Teacher;

ClassMethod Save(studentId As %Integer, teacherId As %Integer) As %Status
{
    set obj = ##class(School.studTeach).%New()
    
    do obj.studentSetObjectId(studentId)
    do obj.teacherSetObjectId(teacherId)

    set result = obj.%Save()
    Return result
}

Method getAll(data) As %String
{
	set data = []
	&sql(
	 	DECLARE MyCursor CURSOR FOR
	    SELECT ID, student, teacher
	    INTO :ID, :student, :teacher
	    FROM School.StudTeach
 	)
 	&sql(OPEN MyCursor)
 	
  FOR { 
    &sql(FETCH MyCursor)
    if (SQLCODE) quit

    set r = ##class(School.studTeach).%OpenId(ID)


    set obj = {"Студент": (r.student.fio), "Курс": (r.student.course)}
    do data.%Push(obj)
 	}
 	&sql(CLOSE MyCursor)
 	
 	quit
}

Storage Default
{
<Data name="studTeachDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>student</Value>
</Value>
<Value name="3">
<Value>teacher</Value>
</Value>
</Data>
<DataLocation>^School.studTeachD</DataLocation>
<DefaultData>studTeachDefaultData</DefaultData>
<IdLocation>^School.studTeachD</IdLocation>
<IndexLocation>^School.studTeachI</IndexLocation>
<StreamLocation>^School.studTeachS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
