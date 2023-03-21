<!DOCTYPE html>
<html>
<script>
    function floatToEuro(float){
    var euroCurrency 
    euroCurrency = '\u20AC' + float.toLocaleString('nl-NL',{minimumFractionDigits: 2});
    console.log(euroCurrency);
    return euroCurrency;
};
</script>
<head>
<style>
    .item1 { grid-area: header; }
    .item3 { grid-area: main; }
    .item2 { grid-area: menu; }
    .item4 { grid-area: right; }
    .item5 { grid-area: footer; }

    .grid-container {
    display: grid;
    grid-template-areas:
        'header header header header header header'
        'menu main main main right right'
        'menu footer footer footer footer footer';
    gap: 10px;
    background-color: none;
    padding: 10px;
    }

    .grid-container > div {
    background-color: #eee;
    text-align: center;
    padding: 20px 0;
    font-size: 30px;
    }
</style>
</head>
<body>
<div class="grid-container">
    <div class="item1">Header</div>
    <div class="item3">Main</div>  
    <div class="item2">Menu</div>
    <div class="item4">Right</div>
    <div class="item5">Footer</div>
</div>

</body>
</html>