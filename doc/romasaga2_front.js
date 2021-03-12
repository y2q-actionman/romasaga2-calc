//
// Util
//

function invokeChangeEvent(targetElem) {
    targetElem.dispatchEvent(new Event("change"));
}

function makeListByProperty(iterable, propertyName, excludeFalse) {
    let ret = [];
    for (i of iterable) {
	let v = i[propertyName];
	if (v || ! excludeFalse) {
	    ret.push(v);
	}
    }
    return ret;
}

//
// onChange handlers
//

function invokeAllCharacterChangeEvent() {
    for(i of document.querySelectorAll('.character')){
	invokeChangeEvent(i);
    }
}

function handleCharacterNameChangeEvent(characterElem, value) {
    updateEquipWaza(characterElem,
		    findCharacter初期技List(value, makeDojoWazaList()));
    const 閃きTypeId = find閃きTypeIdByCharacterName(value)
    characterElem.querySelector('.hiramekiTypeId').value = 閃きTypeId;
    characterElem.querySelector('.hiramekiTypeName').value = find閃きTypeNameBy閃きTypeId(閃きTypeId);
}

function handleHiramekiTypeIdChangeEvent(characterElem, value) {
    characterElem.querySelector('.charactername').value = null;
    characterElem.querySelector('.hiramekiTypeName').value = find閃きTypeNameBy閃きTypeId(value);
}

function handleHiramekiTypeNameChangeEvent(characterElem, value) {
    characterElem.querySelector('.charactername').value = null;
    characterElem.querySelector('.hiramekiTypeId').value = find閃きTypeIdBy閃きTypeName(value);
}

//
// 'equipWaza' handling.
//

function makeDojoWazaList() {
    return makeListByProperty(document.querySelectorAll('#dojo input:checked'), "name");
}

function makeEquipWazaList(characterElem) {
    return makeListByProperty(characterElem.querySelectorAll("input.equipWaza"), "value", true);
}

function updateEquipWaza(characterElem, wazaList) {
    const equipWazaInputs = characterElem.querySelectorAll('input.equipWaza');
    for (let i = 0; i < equipWazaInputs.length; ++i) {
	equipWazaInputs[i].value = (i < wazaList.length) ? wazaList[i] : null;
    }
}

//
// 'hiramekiTable' creation.
//

function buildTBodyCaption(name, colspan) {
    let tr = document.createElement('tr');
    let th = tr.appendChild(document.createElement('th'));
    th.setAttribute("colspan", colspan)
    th.appendChild(document.createTextNode(name));
    return tr;
}

const PROB_FORMATTER = new Intl.NumberFormat(undefined, { style: "percent", maximumFractionDigits: 2, minimumFractionDigits: 2 });

const HIRAMEKI_TABLE_HEADER = ['技名', '確率', '派生元', '技Lv', '固有武器'];

function buildWazaTR(array, isHeader, dojoAvailable) {
    const tr = document.createElement('tr');

    // <tr> class
    if (!isHeader) {
	const calcKwd = array[5];
	if (calcKwd === 'equipped') {
	    tr.classList.add("equipped");
	} else if (calcKwd === 'basic') {
	    ;
	} else if (calcKwd === 'in-dojo') {
	    if (dojoAvailable) {
		;
	    } else {
		tr.classList.add("unavailable");
	    }
	} else if (calcKwd === 'nowhere') {
	    tr.classList.add("unavailable");
	}
    }

    // <td> class
    for (let i = 0; i < HIRAMEKI_TABLE_HEADER.length; ++i) {
	let td = tr.appendChild(document.createElement(isHeader ? 'th' : 'td'));
	let data = array[i];
	if (data) {
	    if(Number.isFinite(data)) {
		td.classList.add("numeric");
		if(!Number.isInteger(data)) {
		    data = PROB_FORMATTER.format(data);
		}
	    }
	    td.appendChild(document.createTextNode(data));
	}
    }
    return tr;
}

function makeWazaTypeList(characterElem) {
    return makeListByProperty(characterElem.querySelectorAll('.wazaFilter input.wazaType:checked'), "name");
} 

function characterIncludeUnique(characterElem) {
    return (characterElem.querySelector('.wazaFilter input.unique:checked')) ? true : false;
} 

function updateHiramekiTable(characterElem) {
    const eLevel = document.querySelector('#enemyTechLevel').value;
    if(!eLevel) return;

    const hiramekiId = characterElem.querySelector('.hiramekiTypeId').value;
    if(!hiramekiId) return;

    const 閃き可能WazaList = find閃き可能WazaListBy閃きTypeId(hiramekiId);
    const wazaTypeList = makeWazaTypeList(characterElem);
    const includeUnique = characterIncludeUnique(characterElem);

    // Building table.
    const table = document.createElement('table');

    // Body
    const equipWazaList = makeEquipWazaList(characterElem);
    const dojoWazaList = makeDojoWazaList();
    const dojoAvailable = document.querySelector("input#dojoAvailable:checked") ? true : false;
    for (wKind of wazaTypeList) {
	let hiramekiList = calcWazaHiramekiList(find技種類技一覧Alist(wKind),
						equipWazaList,
						dojoWazaList,
	  					eLevel,
	  					閃き可能WazaList,
						includeUnique);
	if (!hiramekiList || hiramekiList.length <= 0)
	    continue;

	let tbody = table.appendChild(document.createElement('tbody'));

	let tbodyCap = tbody.appendChild(buildTBodyCaption(wKind, HIRAMEKI_TABLE_HEADER.length));
	tbodyCap.classList.add("tbodyCaption");

	let tbodyHeader = tbody.appendChild(buildWazaTR(HIRAMEKI_TABLE_HEADER, true));
	tbodyHeader.classList.add("tbodyHeader");

	for (i of hiramekiList) {
	    tbody.appendChild(buildWazaTR(i, false, dojoAvailable));
	}
    }

    const outputTable = characterElem.querySelector('.hiramekiTableOutput table');
    outputTable.replaceWith(table);
}

//
// Saving
//

// From https://developer.mozilla.org/ja/docs/Web/API/Web_Storage_API/Using_the_Web_Storage_API
function storageAvailable(type) {
    var storage;
    try {
        storage = window[type];
        var x = '__storage_test__';
        storage.setItem(x, x);
        storage.removeItem(x);
        return true;
    }
    catch(e) {
        return e instanceof DOMException && (
            // everything except Firefox
            e.code === 22 ||
            // Firefox
            e.code === 1014 ||
            // test name field too, because code might not be present
            // everything except Firefox
            e.name === 'QuotaExceededError' ||
            // Firefox
            e.name === 'NS_ERROR_DOM_QUOTA_REACHED') &&
            // acknowledge QuotaExceededError only if there's something already stored
            (storage && storage.length !== 0);
    }
}

function initSaveElement(element) {
    if (storageAvailable('localStorage')) {
    	element.removeAttribute('disabled');
	updateLastSaveDateTimeView();
	// loadFromLocalStorage();
    } else {
	element.setAttribute('disabled', true);
    }
}

function updateLastSaveDateTimeView() {
    const last = localStorage.getItem('lastSaveDateTime');
    document.querySelector('#lastSaveDateTime').value = last ? last : 'なし';
}

function saveToLocalStorage() {
    // Save '#enemy'
    for(elem of document.querySelectorAll('#enemy input')) {
	localStorage.setItem(elem.id, elem.value);
    }
    
    // Save '.character'
    let i = 1;
    for(cElem of document.querySelectorAll('.character')) {
	let obj = {
	    characterName: cElem.querySelector('input.characterName').value,
	    hiramekiTypeId: cElem.querySelector('input.hiramekiTypeId').value,
	    hiramekiTypeName: cElem.querySelector('.hiramekiTypeName').value,
	    wazaFilter: {
		wazaType: makeWazaTypeList(cElem),
		unique: characterIncludeUnique(cElem)
	    },
	    equipWazaList: makeEquipWazaList(cElem)
	};

	localStorage.setItem(('character' + i), JSON.stringify(obj));
	++i;
    }

    // Dojo
    localStorage.setItem('dojoAvailable', document.querySelector('input#dojoAvailable').checked);
    localStorage.setItem('dojoWazaList', JSON.stringify(makeDojoWazaList()));
    
    // update time
    localStorage.setItem('lastSaveDateTime', new Date(Date.now()).toLocaleString());
    updateLastSaveDateTimeView();
    document.querySelector('#save #clearWarning').hidden = true;
}

function loadFromLocalStorage() {
    if(!localStorage.getItem('lastSaveDateTime'))
	return;
    
    // Load '#enemy'
    for(elem of document.querySelectorAll('#enemy input')) {
	elem.value = localStorage.getItem(elem.id);
    }
    
    // Load '.character'
    let i = 1;
    for(cElem of document.querySelectorAll('.character')) {
	const obj = JSON.parse(localStorage.getItem('character' + i));
	
	cElem.querySelector('input.characterName').value = obj.characterName;
	cElem.querySelector('input.hiramekiTypeId').value = obj.hiramekiTypeId;
	cElem.querySelector('.hiramekiTypeName').value = obj.hiramekiTypeName;
	const wazaTypeList = obj.wazaFilter.wazaType;
	if (wazaTypeList) {
	    for (wtElem of cElem.querySelectorAll('.wazaFilter input.wazaType')) {
		wtElem.checked = (wazaTypeList.includes(wtElem.name));
	    }
	}
	cElem.querySelector('.wazaFilter input.unique').checked = obj.wazaFilter.unique;
	updateEquipWaza(cElem, obj.equipWazaList);
	
	++i;
    }

    // Dojo
    document.querySelector('#dojoAvailable').checked = localStorage.getItem('dojoAvailable');
    const dojoWazaList = JSON.parse(localStorage.getItem('dojoWazaList'));
    if (dojoWazaList) {
	for (d of document.querySelectorAll('#dojo input')) {
	    d.checked = (dojoWazaList.includes(d.name));
	}
    }

    // Done
    invokeAllCharacterChangeEvent();
}

function clearLocalStorage() {
    localStorage.clear();
    updateLastSaveDateTimeView();
    document.querySelector('#save #clearWarning').hidden = false;
}
