/**
 * This javascript file checks for the brower/browser tab action.
 * It is based on the file menstioned by Daniel Melo.
 * Reference: http://stackoverflow.com/questions/1921941/close-kill-the-session-when-the-browser-or-tab-is-closed
 */
var validNavigation = false;
 
function endSession() {
  // Browser or broswer tab is closed
  // Do sth here ...
  alert("bye");
}
 
function wireUpEvents() {
  /*
  * For a list of events that triggers onbeforeunload on IE
  * check http://msdn.microsoft.com/en-us/library/ms536907(VS.85).aspx
  */
  window.onbeforeunload = function() {
    
    alert("he");
  }
 
  // Attach the event keypress to exclude the F5 refresh
  $(document).bind('keypress', function(e) {
    if (e.keyCode == 116){
      validNavigation = true;
    }
  });
   
}
 

