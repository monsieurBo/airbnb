document.addEventListener("turbolinks:load", function() {
  $input = $("[data-behavior='autocomplete']")

  var options = {
  	getValue: "country",
  	    url: function(phrase) {
  	      return "/search.json?q=" + phrase;
  	    },
  	    categories: [
  	      {
  	        listLocation: "listings",
  	        header: "<strong>country</strong>",
  	      }
  	    ],
  	    list: {
  	      onChooseEvent: function() {
  	        var url = $input.getSelectedItemData().url
  	        $input.val("")
  	        Turbolinks.visit(url)
  	      }
  	    }
  }

  $input.easyAutocomplete(options)
});