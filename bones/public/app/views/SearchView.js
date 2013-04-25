var Search = Backbone.Model.extend({});
var search_object = new Search(
	{keywords: 'C++', id: 1}
);
var Search_View = Backbone.View.extend({
	render: function() {
		$(this.el).html('<li>' + this.model.get('keywords') + '</li>');	
	}
});
var search_view_object = new Search_View({model: Search});
search_view_object.render();
$('#app').html(search_view_object.el)
alert(search_view_object.el)