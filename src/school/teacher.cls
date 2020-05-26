Class School.Teacher Extends %Persistent
{

Property fio As %String;

Storage Default
{
<Data name="TeacherDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>fio</Value>
</Value>
</Data>
<DataLocation>^School.TeacherD</DataLocation>
<DefaultData>TeacherDefaultData</DefaultData>
<IdLocation>^School.TeacherD</IdLocation>
<IndexLocation>^School.TeacherI</IndexLocation>
<StreamLocation>^School.TeacherS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

ClassMethod SaveTeacher(newObj As School.Teacher) As %Status
{
    Set obj = ##class(School.Teacher).%New()

    Set obj.fio = newObj.fio
    Set x = obj.fioIsValid(obj.fio)

    set result = obj.%Save()
    Return result
}

ClassMethod DeleteTeacher(ID As %Integer) As %Status
{
    set result = ##class(School.Teacher).%DeleteId(ID)
    Return result
}

// ClassMethod GetTeacher(ID As %Integer) As %Status

// {

//     Set obj = ##class(School.Teacher).%OpenId(ID)

//     Return obj

// }

// ClassMethod GetTeacherList() As %String

// {

//     set data = []

//     &sql(

//         DECLARE MyCursor CURSOR FOR

//         SELECT ID, fio

//         INTO :ID, :Fio,

//         FROM School.Teacher

//     )

//     &sql(OPEN MyCursor)   

//     FOR { 

//         &sql(FETCH MyCursor)

//         if (SQLCODE) quit

//         set obj = {"id": (ID), "fio": (Fio)}

//         do data.%Push(obj)

//    }

//    &sql(CLOSE MyCursor)

//    return data

//    quit

// }

Method getAll(data) As %String
{
    set data = []
    &sql(
        DECLARE MyCursor CURSOR FOR
	    SELECT id, fio
	    INTO :id, :fio
	    FROM School.Teacher 
    )
    &sql(OPEN MyCursor)

  FOR { 
    &sql(FETCH MyCursor)
    if (SQLCODE) quit

    set obj = {"id": (id), "fio": (fio), "value": (fio)}
    do data.%Push(obj)
 	}
 	&sql(CLOSE MyCursor)
 	
 	quit
}

}
