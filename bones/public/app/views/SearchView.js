$(document).ready(function() {
	var Search = Backbone.Model.extend({});
	var _search = new Search(
		{ keywords: 'C++' }
	);

	var SearchView = Backbone.View.extend({
		render: function() {
			$(this.el).html('<li>' +  this.model.get('keywords') + '</li>');	
		}
	});
	var _searchView = new SearchView(
		{ model: _search }
	);

	_searchView.render();
	$("#app").append(_searchView.el);
});