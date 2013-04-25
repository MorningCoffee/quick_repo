var Search = Backbone.Model.extend({});
var search = new Search(
	{ keywords: 'C++', id: 1 }
);

var SearchView = Backbone.View.extend({
	render: function() {
		$(this.el).html('<li>' +  this.model.get('keywords') + '</li>');	
	}
});
var searchView = new SearchView(
	{ model: search }
);

searchView.render();
$('#app').append(searchView.el)
console.log(searchView.el);