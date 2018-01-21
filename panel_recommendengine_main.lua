local RAT_VIEW = 0
local isDevelopment = ToClient_IsDevelopment()
function PaGlobal_RecommendEngine_CashVeiw(CashProductNo)
  ToClient_sendRecommendInfoCashShop(RAT_VIEW, CashProductNo)
end
function PaGlobal_RecommendEngine_ItemMarketVeiw(ItemEnchantKey)
  ToClient_sendRecommendInfoItemMarket(RAT_VIEW, ItemEnchantKey)
end
