
ShopUI = {
    config: {
        folderName: "galvao_shop",
        luaActions: {
            buyItem: "buyItem",
            close: "close"
        }
    },

    dom: {
        classItems: ".items",
        classSections: ".sections",

        classContainer: ".container",
        classItem: ".parent",
        classSection: ".section"
    },

    init: function () {
        let that = ShopUI;
        $(that.dom.classContainer).hide();

        that.keyboardWatcher();
        that.windowEvents();
    },

    sendActionLua: function (actionName, data) {
        let that = ShopUI;

        $.post('http://' + that.config.folderName + '/' + actionName, JSON.stringify(data));
    },

    windowEvents: function () {
        window.addEventListener('message', function (event) {
            var data = event.data;
            let that = ShopUI;

            if (data.toogleUi !== undefined) {
                that.methods.toogleUI(data.toogleUi, data.zone, data.vendas)
            }
        });
    },

    keyboardWatcher: function () {
        let that = ShopUI;

        $(document).keyup(function (e) {
            if (e.key === "Escape") {
                that.sendActionLua(that.config.luaActions.close, null)
            }
        });
    },

    methods: {
        buyItem: function (itemSelector) {
            let that = ShopUI;

            let item = $(itemSelector).attr('data-item');
            let zone = $(itemSelector).attr('data-zone');
            let section = $(itemSelector).attr('data-section');

            that.sendActionLua(that.config.luaActions.buyItem, {
                item: item,
                zone: zone,
                section: section
            })
        },

        toogleUI: function (show, zone, itens) {
            let that = ShopUI;

            if (show) {
                that.methods.createItems(itens, zone)
                $(that.dom.classContainer).show()
            } else {
                $(that.dom.classContainer).fadeOut(100);
                that.methods.clearItems()
                that.methods.clearSections()
            }
        },

        toogleItems: function (key) {
            let that = ShopUI;

            $(that.dom.classItem).hide();
            $("." + key).show();
        },

        createItems: function (vendas, zone) {
            let first = false;
            let that = ShopUI;

            Object.keys(vendas).forEach(function (key) {
                let type = vendas[key];
                if (!first) {
                    first = key;
                }
                that.domBuilders.createMenuItemDiv(key, type.Icone);
                type.Items.forEach(function (value) {
                    that.domBuilders.createNewItemDiv(key, zone, value);
                });
            });

            setTimeout(function () {
                $('button[data-sub="' + first + '"]').click();
            }, 100);
        },

        clearSections: function () {
            let that = ShopUI;

            $(that.dom.classSections).empty()
        },

        clearItems: function () {
            let that = ShopUI;

            $(that.dom.classItems).empty()
        }
    },

    domBuilders: {
        createMenuItemDiv: function (key, icone) {
            let that = ShopUI;

            let html = `<button class="section" data-sub="${key}" onclick="ShopUI.methods.toogleItems('${key}')"><img src="images/${icone}"/></button>`;
            $(that.dom.classSections).append(html)
        },

        createNewItemDiv: function (key, zone, data) {
            let that = ShopUI;

            let html = `<div class="parent ${key}" data-section="${key}" data-item="${data.item}" data-zone="${zone}" style="display: none;" onclick="ShopUI.methods.buyItem(this)">
                <div class="img"><img src="images/${data.imglink}" /></div>
                <div class="text">${data.itemLabel}</div>
                <div class="price">$ ${data.price.toLocaleString()}</div>
            </div>
            `;


            $(that.dom.classItems).append(html)
        }
    },
};