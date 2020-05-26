Class School.Schedule Extends %Persistent
{

Property group As School.Gruppa;

Property audience As School.Audience;

Property lesson As School.Lessons;

Storage Default
{
<Data name="ScheduleDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>group</Value>
</Value>
<Value name="3">
<Value>audience</Value>
</Value>
<Value name="4">
<Value>teacher</Value>
</Value>
<Value name="5">
<Value>lesson</Value>
</Value>
</Data>
<DataLocation>^School.ScheduleD</DataLocation>
<DefaultData>ScheduleDefaultData</DefaultData>
<IdLocation>^School.ScheduleD</IdLocation>
<IndexLocation>^School.ScheduleI</IndexLocation>
<StreamLocation>^School.ScheduleS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

ClassMethod Save(groupId As %Integer, audienceId As %Integer, teacherId As %Integer, lessonId As %Integer) As %Status
{
    set obj = ##class(School.Schedule).%New()
    
    do obj.groupSetObjectId(groupId)
    do obj.audienceSetObjectId(audienceId)
    do obj.teacherSetObjectId(teacherId)
    do obj.lessonSetObjectId(lessonId)

    set result = obj.%Save()
    Return result
}

}
