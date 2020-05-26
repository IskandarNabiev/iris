Class School.Api Extends %CSP.REST
{

Parameter HandleCorsRequest = 1;

/// Docs here https://cedocs.intersystems.com/latest/csp/docbook/DocBook.UI.Page.cls?KEY=GREST_services#GREST_urlmap
XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
  <Route Url="/teacher/create" Method="POST" Call="TeacherSave"/>
  <Route Url="/teacher/list" Method="GET" Call="TeacherGetAll"/>
  <Route Url="/teacher/delete" Method="DELETE" Call="TeacherDelete"/>
  

  <Route Url="/lesson/create" Method="POST" Call="LessonSave"/>
  <Route Url="/lesson/list" Method="GET" Call="LessonGetAll"/>
  <Route Url="/lesson/delete" Method="DELETE" Call="LessonDelete"/>
  

  <Route Url="/group/create" Method="POST" Call="GroupSave"/>
  <Route Url="/group/list" Method="GET" Call="GroupGetAll"/>
  <Route Url="/group/delete" Method="DELETE" Call="GroupDelete"/>
 

  <Route Url="/student/create" Method="POST" Call="StudentSave"/>
  <Route Url="/student/list" Method="GET" Call="StudentGetAll"/>
  <Route Url="/student/delete" Method="DELETE" Call="StudentDelete"/>
 


  <Route Url="/student/addstudgroup" Method="POST" Call="AddStudGroup"/>
  <Route Url="/student/addteach" Method="POST" Call="AddTeach"/>
  <Route Url="/student/all" Method="GET" Call="GetAll"/>
  


</Routes>
}

ClassMethod TeacherSave() As %Status
{
  set obj = {}
  set obj.fio = %request.Get("fio")
  set saveResult = ##class(School.Teacher).SaveTeacher(obj)
  set result = {}
  if $$$ISERR(saveResult) {
      set result = {"result": false}
  }
  else {
      set result = {"result": true}
  }
  write result.%ToJSON()
    set ErrorMessage = ##class(%SYSTEM.Status).GetErrorText(saveResult)
    set result.message = ErrorMessage

    Return $$$OK
}

ClassMethod TeacherDelete() As %Status
{
    set id = %request.Get("id")
    set saveResult = ##class(School.Teacher).DeleteTeacher(id)
    set result = {}
    if $$$ISERR(saveResult) {
       set result = {"result": false}
    }
    else {
       set result = {"result": true}
    }
    write result.%ToJSON()
    
    Return $$$OK
}

ClassMethod TeacherGetAll() As %Status
{
    Try {
        set obj = ##class(School.Teacher).%New()
        do obj.getAll(.arr)
        write arr.%ToJSON()
        Return $$$OK
    } Catch {
        set result = {"result": false}
        set result.message = $ZCVT(exception.Name_" "_exception.Location, "O", "HTML")
        write result.%ToJSON()
        Return $$$ERROR(500)
    }
}

ClassMethod LessonSave() As %Status
{
  set obj = {}
  set obj.lesson = %request.Get("lesson")
  set obj.hour = %request.Get("hour")
  set saveResult = ##class(School.Lessons).SaveLesson(obj)
  set result = {}
  if $$$ISERR(saveResult) {
      set result = {"result": false}
  }
  else {
      set result = {"result": true}
  }
  write result.%ToJSON()
    set ErrorMessage = ##class(%SYSTEM.Status).GetErrorText(saveResult)
    set result.message = ErrorMessage

    Return $$$OK
}

ClassMethod LessonDelete() As %Status
{
    set id = %request.Get("id")
    set saveResult = ##class(School.Lessons).DeleteLesson(id)
    set result = {}
    if $$$ISERR(saveResult) {
       set result = {"result": false}
    }
    else {
       set result = {"result": true}
    }
    write result.%ToJSON()
    
    Return $$$OK
}

ClassMethod LessonGetAll() As %Status
{

    Try {
        set obj = ##class(School.Lessons).%New()
        do obj.getAll(.arr)
        write arr.%ToJSON()
        Return $$$OK

    } Catch {

        set result = {"result": false}
        set result.message = $ZCVT(exception.Name_" "_exception.Location, "O", "HTML")
        write result.%ToJSON()
        Return $$$ERROR(500)

    }
}

// Group

ClassMethod GroupSave() As %Status
{
  set obj = {}
  set obj.course = %request.Get("course")
  set obj.spes = %request.Get("spes")
  set saveResult = ##class(School.Gruppa).SaveGroup(obj)
  set result = {}
  if $$$ISERR(saveResult) {
      set result = {"result": false}
  }
  else {
      set result = {"result": true}
  }
  write result.%ToJSON()
    set ErrorMessage = ##class(%SYSTEM.Status).GetErrorText(saveResult)
    set result.message = ErrorMessage

    Return $$$OK
}

ClassMethod GroupDelete() As %Status
{
    set id = %request.Get("id")
    set saveResult = ##class(School.Gruppa).DeleteGroup(id)
    set result = {}
    if $$$ISERR(saveResult) {
       set result = {"result": false}
    }
    else {
       set result = {"result": true}
    }
    write result.%ToJSON()
    
    Return $$$OK
}

ClassMethod GroupGetAll() As %Status
{
    Try {
        set obj = ##class(School.Gruppa).%New()
        do obj.getAll(.arr)
        write arr.%ToJSON()
        Return $$$OK
    } Catch {
        set result = {"result": false}
        set result.message = $ZCVT(exception.Name_" "_exception.Location, "O", "HTML")
        write result.%ToJSON()
        Return $$$ERROR(500)
    }
}

ClassMethod GroupGetOne() As %Status
{
    set id = %request.Get("id")
    try {
        set gruppa = ##class(School.Gruppa).GetGruppa(id)
        set obj = {}
        #; set obj."course" = gruppa.course
	    set obj."spes" = gruppa.spes
        set source = obj.%ToJSON()
	    write source
        Return $$$OK
    } Catch {
        Return $$$ERROR(404)
    }
}

// Add student

ClassMethod StudentAdd() As %Status
{
    set fioId = %request.Get("fio")
    set birthId = %request.Get("birth")
    set groupId = %request.Get("group")
    set lessonId = %request.Get("lesson")
    set teacherId = %request.Get("teacher")


    set saveResult = ##class(School.Student).Save(fioId, birthId, groupId,
    lessonId, teacherId)

    set result = {}
    if $$$ISERR(saveResult) {
        set result = {"result": false}
    }
    else {
        set result = {"result": true}
    }
    write result.%ToJSON()
    set ErrorMessage = ##class(%SYSTEM.Status).GetErrorText(saveResult)
    set result.message = ErrorMessage

    Return $$$OK
}

ClassMethod StudentSave() As %Status
{
  set obj = {}
  set obj.fio = %request.Get("fio")
  set obj.birth = %request.Get("birth")
  set obj.course = %request.Get("course")
  set saveResult = ##class(School.Student).SaveStudent(obj)
  set result = {}
  if $$$ISERR(saveResult) {
      set result = {"result": false}
  }
  else {
      set result = {"result": true}
  }
  write result.%ToJSON()
    set ErrorMessage = ##class(%SYSTEM.Status).GetErrorText(saveResult)
    set result.message = ErrorMessage

    Return $$$OK
}

ClassMethod StudentGetAll() As %Status
{
    Try {
        set obj = ##class(School.Student).%New()
        do obj.getAll(.arr)
        write arr.%ToJSON()
        Return $$$OK
    } Catch {
        set result = {"result": false}
        set result.message = $ZCVT(exception.Name_" "_exception.Location, "O", "HTML")
        write result.%ToJSON()
        Return $$$ERROR(500)
    }
}

ClassMethod StudentDelete() As %Status
{
    set id = %request.Get("id")
    set saveResult = ##class(School.Student).DeleteStudent(id)
    set result = {}
    if $$$ISERR(saveResult) {
       set result = {"result": false}
    }
    else {
       set result = {"result": true}
    }
    write result.%ToJSON()
    
    Return $$$OK
}

ClassMethod AddStudGroup() As %Status
{
    set groupId = %request.Get("group")
    set studentId = %request.Get("student")

    set saveResult = ##class(School.studGroup).Save(groupId, studentId)

    set result = {}
    if $$$ISERR(saveResult) {
        set result = {"result": false}
    }
    else {
        set result = {"result": true}
    }
    write result.%ToJSON()
    set ErrorMessage = ##class(%SYSTEM.Status).GetErrorText(saveResult)
    set result.message = ErrorMessage

    Return $$$OK
}

ClassMethod AddTeach() As %Status
{
    set teacherId = %request.Get("teacher")
    set studentId = %request.Get("student")

    set saveResult = ##class(School.studTeach).Save(teacherId, studentId)

    set result = {}
    if $$$ISERR(saveResult) {
        set result = {"result": false}
    }
    else {
        set result = {"result": true}
    }
    write result.%ToJSON()
    set ErrorMessage = ##class(%SYSTEM.Status).GetErrorText(saveResult)
    set result.message = ErrorMessage

    Return $$$OK
}

ClassMethod GetAll() As %Status
{
    Try {
        set obj = ##class(School.studTeach).%New()
        do obj.getAll(.arr)
        write arr.%ToJSON()
        Return $$$OK
    } Catch {
        set result = {"result": false}
        set result.message = $ZCVT(exception.Name_" "_exception.Location, "O", "HTML")
        write result.%ToJSON()
        Return $$$ERROR(500)
    }
}

}
