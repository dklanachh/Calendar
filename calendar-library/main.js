function toggleCalendar(elmClass, trigger) {
	elmClass = "." + elmClass;
	trigger = "#" + trigger;

	$(trigger).click(function() {

		if ($(trigger).hasClass("off")) {
			$(elmClass).show(null, null, 150, null);
		}
		else {
			$(elmClass).hide(null, null, 150, null);
		}
		$(this).toggleClass("off");
	});

}
