$(document).ready(function() {
	var Search = Backbone.Model.extend({});
	var _search = new Search(
		{ keywords: 'C++' }
	);

	var SearchView = Backbone.View.extend({
		el: "#app",

		events: {
			"change": "changeListener",
			"submit": "submitListener"
		},

		submitListener: function(e) {
			alert("Alah akbar");
		},

		changeListener: function(e){
			console.log("Changed: " + e);
		},

		render: function(){
			var html = '<div class="container-fluid">' +
				'<div class="row-fluid">' +
					'<div class="span12">' +
						'<form>' +
							'<fieldset>' +
								'<legend>Search panel</legend>' +
								'<label>Keywords</label>' +
								'<input type="text" name="keywords"/>' +
								'<label>Categories</label>' +
								'<input type="text" name="categories"/>' +
							'</fieldset>' +
							'<fieldset>' +
								'<button type="submit" class="btn">Search</button>' +
							'</fieldset>' +
						'</form>' +
					'</div>' +
				'</div>' +
			'</div>';
			
			$(this.el).html(html);
		}
	});
	var _searchView = new SearchView(
		{ model: _search }
	);

	_searchView.render();
});