Class School.Student Extends %Persistent
{

Property fio As %String;

Property birth As %String;

Property course As %Integer;

ClassMethod SaveStudent(newObj As School.Student) As %Status
{
    Set obj = ##class(School.Student).%New()

    Set obj.fio = newObj.fio
    Set x = obj.fioIsValid(obj.fio)
    Set obj.birth = newObj.birth
    Set x = obj.birthIsValid(obj.birth)
    Set obj.course = newObj.course
    Set x = obj.courseIsValid(obj.course)

    set result = obj.%Save()
    Return result
}

ClassMethod DeleteStudent(ID As %Integer) As %Status
{
    Set result = ##class(School.Student).%DeleteId(ID)
    Return result
}

// Method getStudent(data) As %String

// {

//     set data = []

// 	&sql(

// 	 	DECLARE MyCursor CURSOR FOR

// 	    SELECT ID, fio

// 	    INTO :ID, :Fio

// 	    FROM School.Student

//  	)

//  	&sql(OPEN MyCursor)

//   FOR { 

//     &sql(FETCH MyCursor)

//     if (SQLCODE) quit

//     set obj = {"id": (ID), "fio": (Fio), "value": (Fio)}

//     do data.%Push(obj)

//  	}

//  	&sql(CLOSE MyCursor)

//  	quit

// }

Method getAll(data) As %String
{
	set data = []
	&sql(
	 	DECLARE MyCursor CURSOR FOR
	    SELECT ID, fio, birth, course
	    INTO :ID, :Fio, :Birth, Course
	    FROM School.Student
 	)
 	&sql(OPEN MyCursor)
 	
  FOR { 
    &sql(FETCH MyCursor)
    if (SQLCODE) quit

    set obj = {"id": (ID), "fio": (Fio), "birth": (Birth),  "course": (Course), "value": (Fio)}
    do data.%Push(obj)
 	}
 	&sql(CLOSE MyCursor)
 	
 	quit
}

Storage Default
{
<Data name="StudentDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>fio</Value>
</Value>
<Value name="3">
<Value>birth</Value>
</Value>
<Value name="4">
<Value>course</Value>
</Value>
</Data>
<DataLocation>^School.StudentD</DataLocation>
<DefaultData>StudentDefaultData</DefaultData>
<IdLocation>^School.StudentD</IdLocation>
<IndexLocation>^School.StudentI</IndexLocation>
<StreamLocation>^School.StudentS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
