Class School.Lessons Extends %Persistent
{

Property lesson As %String;

Property hour As %Integer;

ClassMethod SaveLesson(newObj As School.Lessons) As %Status
{
    Set obj = ##class(School.Lessons).%New()

    Set obj.lesson = newObj.lesson
    set x = obj.lessonIsValid(obj.lesson)

    Set obj.hour = newObj.hour
    set x = obj.hourIsValid(obj.hour)

    set result = obj.%Save()
    Return result
}

ClassMethod DeleteLesson(ID As %Integer) As %Status
{
    Set result = ##class(School.Lessons).%DeleteId(ID)
    Return result
}

Method getAll(data) As %String
{
    set data = []
    &sql(
        DECLARE MyCursor CURSOR FOR
	    SELECT id, lesson, "hour"
	    INTO :id, :lesson, :hour
	    FROM School.Lessons 
    )
    &sql(OPEN MyCursor)
  FOR { 
    &sql(FETCH MyCursor)
    if (SQLCODE) quit
    set obj = {"id": (id), "lesson": (lesson), "hour": (hour)}
    do data.%Push(obj)
 	}
 	&sql(CLOSE MyCursor)
 	quit
}

Storage Default
{
<Data name="LessonsDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>lesson</Value>
</Value>
<Value name="3">
<Value>hour</Value>
</Value>
</Data>
<DataLocation>^School.LessonsD</DataLocation>
<DefaultData>LessonsDefaultData</DefaultData>
<IdLocation>^School.LessonsD</IdLocation>
<IndexLocation>^School.LessonsI</IndexLocation>
<StreamLocation>^School.LessonsS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
