$(document).ready(function() {
  $("#city-search").on("keyup", function(){
    console.log("entered city search");
    autocomplete()
  });
  console.log("2");
  function autocomplete(){
    $.ajax({
      url: '/search',
      type: 'GET',
      data: $("#city-search").serialize(), //takes the form data and authenticity toke and converts it into a standard URL
      dataType: 'json', //specify what type of data you're expecting back from the servers
      error: function() {
          console.log("Something went wrong");
      },
      success: function(data) {

        Array.prototype.unique = function() {
          return this.filter(function (value, index, self) { 
            return self.indexOf(value) === index;
          });
        }
        $("#search-result-list").html("");

        data.unique().forEach(function(element) {
          var option = document.createElement("option");
          option.value = element;
          $("#search-result-list").append(option);
        });
      }
    });
  }
})