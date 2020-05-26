Class web.Student Extends %CSP.Page
{

ClassMethod OnPage() As %Status
{
  do ..header()
  do ##class(web.Student).body()
  do ..footer()
    Quit $$$OK
}

ClassMethod header() As %Status
{
  &HTML<
  <html>
    <head>
      <script type="text/javascript" src="webix/webix.min.js" ></script>
      <link rel="stylesheet" type="text/css" href="webix/webix.min.css">
      <link rel="stylesheet" href="https://cdn.materialdesignicons.com/2.7.94/css/materialdesignicons.css?v=7.2.0" type="text/css" charset="utf-8">
    </head>
  >

  Quit $$$OK
}

ClassMethod body() As %Status
{
  &JS<
<script type="text/javascript">
  var submitStudent = (rawData) => {
    let data = JSON.parse(rawData);
    let message;
    if (data.result) {
      message = { type:"success", text: "Студент сохранен", expire: 2000};
      $$('tab2_content').clear();
    }
    else
      message = { type:"error", text: data.message, expire:2000};
    webix.message(message);
  }

var menu_data = [
	{id: "tab1", icon: "mdi mdi-table", value:"Список студентов"},
	{id: "tab2", icon: "mdi mdi-tie", value:"Добавить студента"},
  {id: "tab3", icon: "mdi  mdi-account-multiple-outline", value:"Назначить группу"},
  {id: "tab4", icon: "mdi mdi-teach", value:"Назначить преподавателя"},
  {id: "tab5", icon: "mdi mdi-table-large", value:"Полный список"},
   
];

var onDelete = () => {
  alert("delete")
};

var student_list_template = {
  id:"tab1_content",
  view:"list",
  template:"<div style='padding-left:18px'> ФИО:#fio#, Год рождения:#birth#, Курс:#course#  </div> <button class='webix_remove_upload' click='onDelete()'>Delete</button>",
  type:{
    height:60
  },
  select:true,  
  url:"/api_sc/student/list",
  onClick:{
        "webix_remove_upload":function(ev, id){
            webix.ajax().del("/api_sc/student/delete?id="+id, { id : id }).then((data) => {
              this.remove(id);
            });
            return false; // blocks the default click behavior
        }
    }
  };

function formatDateNum(num) {
	if (num > 0 && num < 9) {
		return '0' + num;
	}
	return num;
}

function formatDate(date) {
	const d = new Date(date);
	let m = d.getMonth() + 1;
	m = formatDateNum(m);
	const day = formatDateNum(d.getDate());

	return `${day}.${m}.${d.getFullYear()}`;
}

var student_form_template = {
  id:"tab2_content",
  view:"form",
  width: "400",
  elements:[
    {view: "text", name: "fio", label: "ФИО"},
    {view:"datepicker", name: "birth", align:"right",label:"Год/рож."},
    {view: "text", type: "number", name: "course", label: "Курс"},
   // {view: "richselect", name: "group", label: "Группа", value: 1,  options:"/api_sc/group/getone"},
   // {view: "select", name: "lesson", label: "Предмет", options:"/api_sc/lesson/list"},
   // {view: "select", name: "teacher", label: "Преподаватель", options:"/api_sc/teacher/list"},
    { view:"button",  value:"Добавить", id:"btn", click:function(){
      var values = this.getFormView().getValues();
      values.birth = formatDate(values.birth);

      webix.ajax().post("/api_sc/student/create", values, submitStudent);
    }}
  ]};


   
var addStudGroupCallback  = (rawData) => {
    let data = JSON.parse(rawData);
    let message;
    if (data.result) {
      message = { type:"success", text: "Group is added", expire:2000};
      $$('tab3_content').clear();
    }
    else
      message = { type:"error", text: data.message, expire: 2000};
      webix.message(message);
  };

var addStudGroupTemplate = {
  id:"tab3_content",
  view:"form",
  width: "400",
  height: "600",
  elements:[
    {view:"select", name: "group", label:"Группа", value:1, options:"/api_sc/group/list", labelAlign:"right"},
    {view:"select", name: "student", label:"Студент",  options:"/api_sc/student/list", labelAlign:"right" },
    { view:"button",  value:"Submit", id:"btn2", click:function(){
      var values = this.getFormView().getValues();
      webix.ajax().post("/api_sc/student/addstudgroup", values, addStudGroupCallback);
    }}
  ]
};






var addTeachCallback  = (rawData) => {
    let data = JSON.parse(rawData);
    let message;
    if (data.result) {
      message = { type:"success", text: "Teacher is added", expire:2000};
      $$('tab4_content').clear();
    }
    else
      message = { type:"error", text: data.message, expire: 2000};
      webix.message(message);
  };

var addStudTeachTemplate = {
  id:"tab4_content",
  view:"form",
  width: "400",
  height: "600",
  elements:[
    {view:"select", name: "group", label:"Препод", options:"/api_sc/teacher/list", labelAlign:"right"},
    {view:"select", name: "student", label:"Студент",  options:"/api_sc/student/list", labelAlign:"right" },
    { view:"button",  value:"Добавить", id:"btn3", click:function(){
      var values = this.getFormView().getValues();
      webix.ajax().post("/api_sc/student/addteach", values, addTeachCallback);
    }}
  ]
};



var allTemplate = {
  id:"tab5_content",
  view: "datatable",
  width: "500",
  autoConfig:true,
    url:"/api_sc/student/all"
};






var top_menu_data = [
    { id:"1",value:"Преподаватели", href: '/csp/irisapp/web.Teacher.cls'},
    { id:"2",value:"Группы", href: '/csp/irisapp/web.Gruppa.cls'},
    { id:"3",value:"Предметы", href: '/csp/irisapp/web.Lessons.cls'},
    { id:"4",value:"Студенты", href: '/csp/irisapp/web.Student.cls'}
];
var top_menu = {
    view:"menu",
    data: top_menu_data,
    type:{
        subsign:true
    }
};
var top_toolbar = {
    view:"toolbar", css:"webix_dark",  elements:[
        top_menu
    ]
};

var ui_template = {
  height: '100%',
  rows: [
  top_toolbar,
    { view: "toolbar", padding:6, 
      elements: [
        { view: "button", type: "icon", icon: "mdi mdi-menu",
          width: 30, align: "left", css: "app_button", click: function(){
            $$("$sidebar1").toggle();
          }
        },
        { view: "label", label: "IRIS School Management App"},
      ]
    },
    { 
      cols:[
      {
        view: "sidebar",
        css:"webix_dark",
        data: menu_data,
        on:{
          onAfterSelect: function(id){
            $$(`${id}_content`).show();
          }
        }
      },
      { id:"t1_content",
          cells:[
            student_list_template,
            student_form_template,
            addStudGroupTemplate,
            addStudTeachTemplate,
            allTemplate,
           
        ]   
      }
    ]}
  ]};

webix.ready(function(){
  webix.ui(ui_template);
});




</script>
  >
  Quit $$$OK
}

ClassMethod footer() As %Status
{
  &HTML<
    </body></html>
  >
  Quit $$$OK
}

}
