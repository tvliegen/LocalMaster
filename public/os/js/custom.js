function hide_element(obj_name) {
//  var tbl = document.getElementById(obj_name);
  var tbl=$('#'+obj_name);
  
  
  if ($('#'+obj_name).css('display')=='block')
  {
    $('#'+obj_name).hide();
    }
    else {
 $('#'+obj_name).show();
}

}

function switch_lines_view(view_name){

var section_start=0;
var section_end=0;
var min_col=7;
var max_col=21;

if (view_name=='extended') {
  section_start=12;
  section_end=13;
}
if (view_name=='pricing') {
  section_start=7;
  section_end=11;
}
if (view_name=='com') {
  section_start=14;
  section_end=20;
}
for (var i=min_col;i<max_col;i++){
 if (i>=section_start && i<=section_end) {

  $('#lines_table tr *:nth-child('+i+')').removeClass('hidden');
}  
else {
  $('#lines_table tr *:nth-child('+i+')').addClass('hidden');
}
}
}

function updateDoc(obj)
{
    var sourceDoc;
           var docname=$(obj).attr('docname');
           var target=$(obj).attr('target');
           var doc_type=$(obj).attr('doc_type');
           var params=$(obj).attr('params');
           
           if (doc_type=='view') {
             sourceDoc=docname + '_view.html';
              $('#'+target).load(sourceDoc);
            }
              else if (doc_type=='doc') {
              
              
                sourceDoc=docname + '.html';
    //               $('#'+target).load(sourceDoc);
 $('#'+target).load(sourceDoc,function() {
  set_validation_messages(params); 
              

           
});
}
}

function set_invalid_message(section){

         $('#'+section).addClass("icon-invalid");
         $('#'+section).addClass("glyphicon-minus-sign");

}

function set_valid_message(section){

         $('#'+section).addClass("icon-success");
         $('#'+section).addClass("glyphicon-ok-sign");

}

function set_info_message(section){

         $('#'+section).addClass("icon-warning");
         $('#'+section).addClass("glyphicon-info-sign");

}
function set_validation_messages(submission_type){
   

      if (submission_type=='more_info'){
        more_info_messages();
      }
      else if (submission_type=='error'){
        error_messages();
      }
      
       else if (submission_type=='ready'){
        ready_messages();
      }
      }
      
function more_info_messages(){
        $('div.result_header').text("Order Validated with More Information Required");
      
       $('#customer_info_message').html('<img src=\"images/Critical.png\" alt=\"Error\" height=\"48\" width=\"48\" />Invalid Customer Selected.');
          set_invalid_message('customer_info_icon');
          $('customer_info_message').addClass('critical');
        
          $('#sq_info_message').html('<img src=\"images/Info.png\" alt=\"Error\" height=\"48\" width=\"48\" />SQ is expiring in the next 90 days.');
          set_info_message('sq_info_icon');
          $('sq_info_message').addClass('info');
        
        
  $('#shipping_info_message').html('<img src=\"images/Info.png\" alt=\"Error\" height=\"48\" width=\"48\" />Please ensure CBD is available.');
          set_info_message('shipping_info_icon');
        
 $('shipping_info_message').addClass('warning');
        
        
         $('#additional_order_info_message').html('<img src=\"images/Valid.png\" alt=\"Error\" height=\"48\" width=\"48\" />Valid.');
        set_valid_message('additional_order_info_icon');
 
  $('#lines_info_message').html('<img src=\"images/Valid.png\" alt=\"Error\" height=\"48\" width=\"48\" />Valid.');
          set_valid_message('lines_info_icon');
        
        $('#lines_info_message_1').html('<img src=\"images/Valid.png\" alt=\"Error\" height=\"48\" width=\"48\" />Valid.');
$('#lines_info_message_2').html('<img src=\"images/Valid.png\" alt=\"Error\" height=\"48\" width=\"48\" />Valid.');
$('#lines_info_message_3').html('<img src=\"images/Valid.png\" alt=\"Error\" height=\"48\" width=\"48\" />Valid.');
$('#lines_info_message_4').html('<img src=\"images/Valid.png\" alt=\"Error\" height=\"48\" width=\"48\" />Valid.');

        
        
        set_valid_message('lines_info_icon_1');
    
        set_valid_message('lines_info_icon_2');
    
        set_valid_message('lines_info_icon_3');
   
        set_valid_message('lines_info_icon_4');
        
        
        
     $('#required_info_message').html('<img src=\"images/Valid.png\" alt=\"Error\" height=\"48\" width=\"48\" />Valid.');

        set_valid_message('required_info_icon');


}
 
 
 function ready_messages(){
   $('div.result_header').text("Order Validated. Ready to Submit.");
     
  $('#customer_info_message').html('<img src=\"images/Critical.png\" alt=\"Error\" height=\"48\" width=\"48\" />Invalid Customer Selected.');
          set_invalid_message('customer_info_icon');
          $('customer_info_message').addClass('critical');
        
          $('#sq_info_message').html('<img src=\"images/Info.png\" alt=\"Error\" height=\"48\" width=\"48\" />SQ is expiring in the next 90 days.');
          set_info_message('sq_info_icon');
          $('sq_info_message').addClass('info');
        
        
  $('#shipping_info_message').html('<img src=\"images/Info.png\" alt=\"Error\" height=\"48\" width=\"48\" />Please ensure CBD is available.');
          set_info_message('shipping_info_icon');
        
 $('shipping_info_message').addClass('warning');
        
        
         $('#additional_order_info_message').html('<img src=\"images/Valid.png\" alt=\"Error\" height=\"48\" width=\"48\" />Valid.');
        set_valid_message('additional_order_info_icon');
 
  $('#lines_info_message').html('<img src=\"images/Valid.png\" alt=\"Error\" height=\"48\" width=\"48\" />Valid.');
          set_valid_message('lines_info_icon');
        
        $('#lines_info_message_1').html('<img src=\"images/Valid.png\" alt=\"Error\" height=\"48\" width=\"48\" />Valid.');
$('#lines_info_message_2').html('<img src=\"images/Valid.png\" alt=\"Error\" height=\"48\" width=\"48\" />Valid.');
$('#lines_info_message_3').html('<img src=\"images/Valid.png\" alt=\"Error\" height=\"48\" width=\"48\" />Valid.');
$('#lines_info_message_4').html('<img src=\"images/Valid.png\" alt=\"Error\" height=\"48\" width=\"48\" />Valid.');

        
        
        set_valid_message('lines_info_icon_1');
    
        set_valid_message('lines_info_icon_2');
    
        set_valid_message('lines_info_icon_3');
   
        set_valid_message('lines_info_icon_4');
        
        
        
     $('#required_info_message').html('<img src=\"images/Valid.png\" alt=\"Error\" height=\"48\" width=\"48\" />Valid.');

        set_valid_message('required_info_icon');


}
function error_messages(){
          
          $('div.result_header').text("Order Validated with Errors");
       
      
 
          $('#customer_info_message').html('<img src=\"images/Critical.png\" alt=\"Error\" height=\"48\" width=\"48\" />Invalid Customer Selected.');
          set_invalid_message('customer_info_icon');
          $('customer_info_message').addClass('critical');
        
          $('#sq_info_message').html('<img src=\"images/Info.png\" alt=\"Error\" height=\"48\" width=\"48\" />SQ is expiring in the next 90 days.');
          set_info_message('sq_info_icon');
          $('sq_info_message').addClass('info');
        
          $('#shipping_info_message').html('<img src=\"images/Info.png\" alt=\"Error\" height=\"48\" width=\"48\" />Please ensure CBD is available.');
          set_info_message('shipping_info_icon');
         $('shipping_info_message').addClass('warning');
        
        
         $('#additional_order_info_message').html('<img src=\"images/Valid.png\" alt=\"Error\" height=\"48\" width=\"48\" />Valid.');
        set_valid_message('additional_order_info_icon');
 
  $('#lines_info_message').html('<img src=\"images/Valid.png\" alt=\"Error\" height=\"48\" width=\"48\" />Valid.');
          set_valid_message('lines_info_icon');
        
        $('#lines_info_message_1').html('<img src=\"images/Valid.png\" alt=\"Error\" height=\"48\" width=\"48\" />Valid.');
$('#lines_info_message_2').html('<img src=\"images/Valid.png\" alt=\"Error\" height=\"48\" width=\"48\" />Valid.');
$('#lines_info_message_3').html('<img src=\"images/Valid.png\" alt=\"Error\" height=\"48\" width=\"48\" />Valid.');
$('#lines_info_message_4').html('<img src=\"images/Valid.png\" alt=\"Error\" height=\"48\" width=\"48\" />Valid.');

        
        
        set_valid_message('lines_info_icon_1');
    
        set_valid_message('lines_info_icon_2');
    
        set_valid_message('lines_info_icon_3');
   
        set_valid_message('lines_info_icon_4');
        
        
        
     $('#required_info_message').html('<img src=\"images/Valid.png\" alt=\"Error\" height=\"48\" width=\"48\" />Valid.');

        set_valid_message('required_info_icon');
}

//glyphicon glyphicon-minus-sign icon-invalid
/*$(document).ready(function () {
        $('ul.nav > li').click(function (e) {
            e.preventDefault();
            $('ul.nav > li').removeClass('active');
            $(this).addClass('active');  
            updateDoc(this);
            
                    
        });     
  */      
       

