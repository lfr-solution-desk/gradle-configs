(function() {
	function setupHideControlMenuButton() {
		var $ = AUI.$;
		var $body = $('body');
		var $hideControlMenuButton = $('.js-toggle-control-menu');
		var $lfrAddPanel = $('.lfr-add-panel');
		var $lfrProductMenuPanel = $('.lfr-product-menu-panel');

		$hideControlMenuButton.on(
			'click',
			function() {
				$('#combinedMenu').toggleClass('menu-aggregator-down');
				$body.toggleClass('control-menu-up');

				if ($body.hasClass('control-menu-up')) {
					Liferay.Store('com.liferay.jarvis.constants_controlMenuState', 'control-menu-up');

					if ($lfrAddPanel.hasClass('open-admin-panel')) {
						$('[data-qa-id="add"]').click();
					}

					if ($lfrProductMenuPanel.hasClass('open')) {
						$('[data-qa-id="productMenu"]').click();
					}
				}
				else {
					Liferay.Store('com.liferay.jarvis.constants_controlMenuState', '');
				}
			}
		);
	}

	setupHideControlMenuButton();
})();