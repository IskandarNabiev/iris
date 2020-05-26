Class School.Audience Extends %Persistent
{

Property number As %Integer;

Property floor As %Integer;

Storage Default
{
<Data name="AudienceDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>number</Value>
</Value>
<Value name="3">
<Value>floor</Value>
</Value>
</Data>
<DataLocation>^School.AudienceD</DataLocation>
<DefaultData>AudienceDefaultData</DefaultData>
<IdLocation>^School.AudienceD</IdLocation>
<IndexLocation>^School.AudienceI</IndexLocation>
<StreamLocation>^School.AudienceS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

ClassMethod SaveAudience(newObj As School.Audience) As %Status
{

    set obj = ##class(School.Audience).%New()

    set obj.number = newObj.number
    set x = obj.numberIsValid(obj.number)

    set obj.floor = newObj.floor
    set x = obj.floorIsValid(obj.floor)

    set result = obj.%Save()
    return result
}

ClassMethod DeleteAudience(ID As %Integer) As %Status
{
    set result = ##class(School.Audience).%DeleteId(ID)
    Return result
}

ClassMethod GetAudience(ID As %Integer) As School.Audience
{

    set obj = ##class(School.Audience).%OpenId(ID)
    Return obj
}

ClassMethod GetAudienceList() As %String
{

    set data = []
    &sql(
        DECLARE MyCursor CURSOR FOR
        SELECT ID, floor, number
        INTO :ID, :Floor, :Number,
        FROM School.Audience
    )

    &sql(OPEN MyCursor)   
    FOR { 
        &sql(FETCH MyCursor)
        if (SQLCODE) quit
        set obj = {"id": (ID), "floor": (Floor), "number": (Number)}
        do data.%Push(obj)
   }

   &sql(CLOSE MyCursor)
   return data
   quit
}

}
