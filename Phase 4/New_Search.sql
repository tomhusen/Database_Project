CREATE OR REPLACE FUNCTION SEARCH(s_itemID String, s_keyword String, s_category String, s_minBid Decimal, s_maxBid Decimal) RETURN INT AS
  tempReturn INT := 0;
  -- Default value for Item ID
  IF(s_itemID = null)
    THEN s_itemID = *;
  END IF
  -- Default value for Keyword
  IF(s_keyword = null)
    THEN s_keyword = *;
  END IF
  -- Default value for Category
  IF(s_category = null)
    THEN s_category = *;
  END IF
  -- Default value for Min Bid
  IF(s_minBid = null)
    THEN s_minBid = 0.00;
  END IF
  -- Default value for Max Bid
  IF(s_minBid = null)
    THEN s_maxBid = 9999999.99;
  END IF
  
END
  
