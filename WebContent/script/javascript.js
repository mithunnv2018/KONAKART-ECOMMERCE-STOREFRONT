/**
 * javascript for application
 *
 */

/**
* Highlight a row when you pass over it with the mouse
*/
rowOverEffect(object) {
	if (object.className == 'moduleRow') object.className = 'moduleRowOver';
}

/**
* Remove highlight from a row when you pass over it with the mouse
*/
rowOutEffect(object) {
	if (object.className == 'moduleRowOver') object.className = 'moduleRow';
}