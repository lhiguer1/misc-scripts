// ==UserScript==
// @name         IssueTrak Enhancer
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  Fix some IssueTrak QoL issues
// @author       Leonel Higuera
// @match        https://sub-domain.domain.com/*
// @icon         https://www.google.com/s2/favicons?sz=64&domain=domain.com
// @grant        none
// ==/UserScript==


(function() {
    'use strict';

    // set target to null so subsequent urls are opened in their own tab or window
    window.name = null;

    // Change page title to subject of issue
    let newTitle = document.getElementById('inp_hiddenSubject');
    if (newTitle != null) {
        document.title = newTitle.value;
    }
})();
