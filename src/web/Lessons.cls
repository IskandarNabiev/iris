Class web.Lessons Extends %CSP.Page
{

ClassMethod OnPage() As %Status
{
  do ..header()
  do ##class(web.Lessons).body()
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
  var submitCallback = (rawData) => {
    let data = JSON.parse(rawData);
    let message;
    if (data.result) {
      message = { type:"success", text: "Предмет добавлен", expire: 2000};
      $$('tab2_content').clear();
    }
    else
      message = { type:"error", text: data.message, expire:2000};
    webix.message(message);
  }

var menu_data = [
	{id: "tab1", icon: "mdi mdi-table", value:"Список предметов"},
	{id: "tab2", icon: "mdi mdi-pencil", value:"Добавить предмет"},
];

var onDelete = () => {
  alert("delete")
};

var lesson_list_template = {
  id:"tab1_content",
  view:"list",
  template:"<div style='padding-left:18px'> Предмет:#lesson#, Час:#hour# </div> <button class='webix_remove_upload' click='onDelete()'>Удалить</button>",
  type:{
    height:60
  },
  select:true,  
  url:"/api_sc/lesson/list",
    onClick:{
        "webix_remove_upload":function(ev, id){
            webix.ajax().del("/api_sc/lesson/delete?id="+id, { id : id }).then((data) => {
              this.remove(id);
            });
            return false; // blocks the default click behavior
        }
    }



  };


var lesson_form_template = {
  id:"tab2_content",
  view:"form",
  width: "400",
  elements:[
    {view: "text", name: "lesson", label: "Предмет"},
    {view: "text", name: "hour", label: "Час"},
    { view:"button",  value:"Добавить", id:"btn", click:function(){
      var values = this.getFormView().getValues();
      webix.ajax().post("/api_sc/lesson/create", values, submitCallback);
    }}
  ]};

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
    view:"toolbar", css:"webix_dark", elements:[
        top_menu
    ]
};

var ui_template = {
  height: '100%',
  rows: [
  top_toolbar,
    { view: "toolbar",  padding:3, 
      elements: [
        { view: "button", type: "icon", icon: "mdi mdi-menu",
          width: 37, align: "left", css: "app_button", click: function(){
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
            lesson_list_template,
            lesson_form_template
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
