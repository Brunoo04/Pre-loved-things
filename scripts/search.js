const search = document.querySelector('.search-container')

if (search) {
    const input = search.querySelector('input')
    input.addEventListener('input', async () => {
        const response = await fetch('../api/api_search.php?' + encodeForAjax({ q: input.value }))
        const items = await response.json()

        const suggestions = search.querySelector('#search-suggestions');
        suggestions.innerHTML = '';
        for (const item of items) {
            const row = document.createElement('option')
            row.value = item.name;
            suggestions.appendChild(row);
        }
    })
}
let categories = Array();
let conditions = Array();

const optionsPrice = document.querySelector('#Price');
if (optionsPrice) {
    const input = optionsPrice.querySelectorAll('input');
    input.forEach(function(elem) {
        if (elem.checked) categories.push();
    });
    input.forEach(function(elem) {
        elem.addEventListener("input", async () => {
            const index = categories.indexOf(elem.name);
            if (index === -1) categories.push(elem.name);
            else categories.splice(index, 1);
            await getFilteredItems();
        });
    });
}

const optionsConditions = document.querySelector('#Condition');
if (optionsConditions) {
    const input = optionsConditions.querySelectorAll('input');
    input.forEach(function(elem) {
        elem.addEventListener("input", async () => {
            const index = conditions.indexOf(elem.name);
            if (index === -1 && elem.checked) conditions.push(elem.name);
            else if (!elem.checked) conditions.splice(index, 1);
            await getFilteredItems();
        });
    });
}

function encodeForAjax(data) {
    return Object.keys(data).map(function (k) {
        return encodeURIComponent(k) + '=' + encodeURIComponent(data[k])
    }).join('&')
}

document.body.addEventListener('mouseup', noDisplay, true);

function noDisplay() {
    document.getElementById("suggestions").style.display = "none";
}

async function getFilteredItems() {
    console.log(encodeForAjax({cat: categories, cond: conditions}));
    const response = await fetch('../api/api_search_range.php?' + encodeForAjax({cat: categories, cond: conditions}))
    const items = await response.json();
    const searchres = document.querySelector('#searchres');
    searchres.innerHTML = '';
    searchres.appendChild(addItemSection(items));
}

function addItemSection(items) {
    const itm = document.createElement('section');
    itm.className = "items";
    items.forEach(item => itm.appendChild(createItem(item)))
    return itm;
}

function createItem(item) {
    const main = document.createElement('a');
    main.href = "item.php?id=" + item.id;
    main.className = "item";
    const img = document.createElement("img")
    img.src = "../images/flower.png"
    main.appendChild(img);
    const div = document.createElement("div")
    div.className = "item-info"
    const name = document.createElement("p")
    name.innerText = item.name;
    name.className = "name"
    div.appendChild(name);
    const price = document.createElement("p")
    price.innerText = item.price;
    price.className = "price"
    div.appendChild(price);
    main.appendChild(div);
    return main;
}
