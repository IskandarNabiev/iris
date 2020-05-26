Class School.Gruppa Extends %Persistent
{

Property course As %Integer(MAXVAL = 6);

Property spes As %String;

Storage Default
{
<Data name="GruppaDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>course</Value>
</Value>
<Value name="3">
<Value>spes</Value>
</Value>
</Data>
<DataLocation>^School.GruppaD</DataLocation>
<DefaultData>GruppaDefaultData</DefaultData>
<IdLocation>^School.GruppaD</IdLocation>
<IndexLocation>^School.GruppaI</IndexLocation>
<StreamLocation>^School.GruppaS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

ClassMethod SaveGroup(newObj As School.Gruppa) As %Status
{

    set obj = ##class(School.Gruppa).%New()

    set obj.course = newObj.course
    set x = obj.courseIsValid(obj.course)

    set obj.spes = newObj.spes
    set x = obj.spesIsValid(obj.spes)

    set result = obj.%Save()
    return result
}

ClassMethod DeleteGroup(ID As %Integer) As %Status
{

    set result = ##class(School.Gruppa).%DeleteId(ID)
    Return result
}

ClassMethod GetGruppa(ID As %Integer) As School.Gruppa
{
    set obj = ##class(School.Gruppa).%OpenId(ID)
    Return obj
}

Method getAll(data) As %String
{
    set data = []
    &sql(
        DECLARE MyCursor CURSOR FOR
	    SELECT id, course, spes
	    INTO :id, :course, :spes
	    FROM School.Gruppa 
    )
    &sql(OPEN MyCursor)

  FOR { 
    &sql(FETCH MyCursor)
    if (SQLCODE) quit

    set obj = {"id": (id), "course": (course), "spes": (spes), "value":(spes)}
    do data.%Push(obj)
 	}
 	&sql(CLOSE MyCursor)
 	
 	quit
}

}
