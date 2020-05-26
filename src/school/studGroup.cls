Class School.studGroup Extends %Persistent
{

Property student As School.Student;

Property group As School.Gruppa;

ClassMethod Save(groupId As %Integer, studentId As %Integer) As %Status
{
    set obj = ##class(School.studGroup).%New()
    
    do obj.studentSetObjectId(studentId)
    do obj.groupSetObjectId(groupId)

    set result = obj.%Save()
    Return result
}

Storage Default
{
<Data name="studGroupDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>student</Value>
</Value>
<Value name="3">
<Value>group</Value>
</Value>
</Data>
<DataLocation>^School.studGroupD</DataLocation>
<DefaultData>studGroupDefaultData</DefaultData>
<IdLocation>^School.studGroupD</IdLocation>
<IndexLocation>^School.studGroupI</IndexLocation>
<StreamLocation>^School.studGroupS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
