local cfg = {}

-- start wallet/bank values
cfg.open_wallet = 1000000
cfg.open_bank = 10000000
cfg.open_credit = 0
cfg.open_loanlimit = 10000000
cfg.open_loan = 0
cfg.open_creditrating = 7
cfg.open_exp = 0
cfg.open_licrevoked = 0
--cfg.open_exp2 = 0
--cfg.open_stock = 0

cfg.dev = {}
cfg.dev.open_wallet = 100000000
cfg.dev.open_bank = 5000000000
cfg.dev.open_credit = 0
cfg.dev.open_loanlimit = 5000000000
cfg.dev.open_loan = 0
cfg.dev.open_creditrating = 7
cfg.dev.open_exp = 0
cfg.dev.open_licrevoekd = 0
--cfg.dev.open_exp2 = 0
--cfg.dev.open_stock = 0

cfg.display_css =
  [[	
.div_money{
  display:flex;
  justify-content: space-between;
  align-items: center;
  position: absolute;
  top: 60px;
  right: 10px;
  color: white;
  background-color: rgba(0,0,0,0.40);
  padding: 5px 6px;
  width: 250px;
  border-radius: 5px;
  font-size: 20px;
  line-height:26px;
  font-weight: bold;
  text-align:right;
  color: #FFFFFF;
  text-shadow: rgb(0, 0, 0) 1px 0px 0px, rgb(0, 0, 0) 0.533333px 0.833333px 0px, rgb(0, 0, 0) -0.416667px 0.916667px 0px, rgb(0, 0, 0) -0.983333px 0.133333px 0px, rgb(0, 0, 0) -0.65px -0.75px 0px, rgb(0, 0, 0) 0.283333px -0.966667px 0px, rgb(0, 0, 0) 0.966667px -0.283333px 0px;
}
.div_bmoney{
  display:flex;
  justify-content: space-between;
  align-items: center;
  position: absolute;
  top: 100px;
  right: 10px;
  background-color: rgba(0,0,0,0.40);
  padding: 5px 6px;
  width: 250px;
  border-radius: 5px;
  font-size: 20px;
  line-height:26px;
  font-weight: bold;
  text-align:right;
  color: #FFFFFF;
  text-shadow: rgb(0, 0, 0) 1px 0px 0px, rgb(0, 0, 0) 0.533333px 0.833333px 0px, rgb(0, 0, 0) -0.416667px 0.916667px 0px, rgb(0, 0, 0) -0.983333px 0.133333px 0px, rgb(0, 0, 0) -0.65px -0.75px 0px, rgb(0, 0, 0) 0.283333px -0.966667px 0px, rgb(0, 0, 0) 0.966667px -0.283333px 0px;
}

.div_credit{
  display:flex;
  justify-content: space-between;
  align-items: center;
  position: absolute;
  top: 140px;
  right: 10px;
  background-color: rgba(0,0,0,0.40);
  padding: 5px 6px;
  width: 250px;
  border-radius: 5px;
  font-size: 20px;
  line-height:26px;
  font-weight: bold;
  text-align:right;
  color: #FFFFFF;
  text-shadow: rgb(0, 0, 0) 1px 0px 0px, rgb(0, 0, 0) 0.533333px 0.833333px 0px, rgb(0, 0, 0) -0.416667px 0.916667px 0px, rgb(0, 0, 0) -0.983333px 0.133333px 0px, rgb(0, 0, 0) -0.65px -0.75px 0px, rgb(0, 0, 0) 0.283333px -0.966667px 0px, rgb(0, 0, 0) 0.966667px -0.283333px 0px
}
.div_money .symbol{
  width:26px;
  height:26px;
  content: url('https://freeiconshop.com/wp-content/uploads/edd/wallet-flat.png'); 
}

.div_bmoney .symbol{
  width:26px;
  height:26px;
  content: url('https://freeiconshop.com/wp-content/uploads/edd/creditcard-flat.png');
}

.div_credit .symbol{
  width:26px;
  height:26px;
  content: url('https://cdn3.iconfinder.com/data/icons/finance-152/64/29-512.png');
}
]]

return cfg
