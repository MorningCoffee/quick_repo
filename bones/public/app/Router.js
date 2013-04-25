window.App = new (Backbone.Router.extend({
	routes: {
		"": "index"
	},

	index: function() {
		alert('Hello');
	},

	initialize: function() {
		console.log("App> Initializing routes...");
		console.log("App> Routes " + JSON.stringify(this.routes, null, '\t'));		
	}, 

	start: function() {
		Backbone.history.start({
			pushState: true
		});
	}
}));