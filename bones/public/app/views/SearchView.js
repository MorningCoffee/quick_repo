$(document).ready(function() {
	var Search = Backbone.Model.extend({});
	var _search = new Search(
		{ keywords: 'C++' }
	);

	var SearchView = Backbone.View.extend({
		el: "#app",

		events: {
			"change": "changeListener",
			"submit form#anton": "submitListener"
		},

		submitListener: function(e) {
			alert("Alah akbar");
		},

		changeListener: function(e){
			console.log("Changed: " + e);
		}
	});
	var _searchView = new SearchView(
		{ model: _search }
	);
});