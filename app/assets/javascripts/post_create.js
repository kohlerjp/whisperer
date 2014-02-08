$(document).ready(function() {

    // handle friend input search
    var friends = [];

    $.getJSON('http://whisperer.herokuapp.com/users/friends/{user-id}.json',
            function(data) {
                friends = data;
            });

    $(".input_post_search_names").on("keyup", function () {
        var name = this.value;

        if (name.length < 3) {
            $('.input-search-suggest')[0].innerHTML = '';
        } else {
            results = find(name, friends);
            suggest(results, $('.input-search-suggest')[0]);
        }

    });

    $(".input_post_text").on("keyup keydown blur", function () {
        var name = this.value;

        if (name.length >= 130) {
            this.value = name.substring(0, 130);
        }

        $('.word-counter').text((130 - this.value.length) + ' out of 130 characters remaining');

    });

});

// find the given name in the list of tokens
var find = function (name, friends) {
    // the array of results
    var results = [];
    // serach the tokens for potential matches
    for (var i = 0; i < friends.length; i++) {
        // create a new regular expression, which will find the name
        var findname = new RegExp("\\b" + name + "[a-zA-Z]*");
        // if the token is a substring
        var found = findname.exec(friends[i].name);
        // if we find the name add it to the results
        if (found !== null) results.push(friends[i]);
    }
    // return all the results
    return results;
};

// suggests matches based on the give array
var suggest = function (matches, suggestions) {
    // clear the suggestions box
    suggestions.innerHTML = '';
    // iterate through all the matches
    for (var i = 0; i < matches.length; i++) {
        // create a div element for every match
        var elem = document.createElement('div');
            elem.className = 'post_box_person_create person' + matches[i].id;
            elem.innerHTML = '<a href="#"><div class="pull-left"><img src="' + matches[i].image +'" class="img_face img-circle img-responsive"></div>' +
                    '<div class="pull-left"><div class="post_name_create">' + matches[i].name +
                    '</div></div><div class="clearfix"></div></div></a>';
            elem.onclick = slideSelect.bind(this, matches[i]);
        // add the div element to the suggestions
        suggestions.appendChild(elem);
    }
};

var slideSelect = function (match) {

    $('.input-search-box').animate({
        opacity: 0,
        'margin-top': '-200px'
     }, 300, function() {
        $('.input-message,.input-submit').fadeIn(300);
     });

    $('.input-search-suggest').animate({
        'margin-top': '150px'
     }, 300, function() {});

    $('.post_box_person_create:not(.person' + match.id + ')').animate({
        opacity: 0,
        height: 0,
        'margin-top': 0, 'margin-bottom': 0, padding: 0,
        overflow: 'hidden'
     }, 300, function() {
        this.remove();
     });

};
