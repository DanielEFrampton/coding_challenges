# Initial thoughts
# Maximum profit implies taking the best path out of all possible
# trading routes, which requires some kind of pre-processing
# of the array and not a single iterative path; or quadriliateral.
# (That is, unless I know ahead of time that the price will
# never be lower that the first element, there would be
# no way to decided whether or not to purchase it.)
# Constraints:
    # Quantity is not a factor here; it assumes a single unit purchase.
# Thinking through the first example, [7,1,5,3,6,4]:
# Iterate through each element in the array:
    # If none bought:
        # Is this the last element? If so, take no action
        # Is the current element less than the next? 
            # If so, buy
            # if not, no action
    # If stock has been purchased:
        # Is the current element greater than previous purchase price?
            # If so, sell
            # If not, no action
# This algorithm would work for the 1st and 3rd example, but not for 2nd.
# Need to look for the next highest element.
    # Buying and selling on an upward slope, even though more transactions
    # could be completed, would never amount to gains of waiting because of the delay
    # imposed by the single-transaction-per-day policy
    # E.g., [1,2,3,4]:
        # Buy on day 1, sell day 2: 1 profit
        # Buy on day 3, sell day 4: 1 profit (total 2)
        # Buy on day 1, sell day 3: 2 profit
        # Buy on day 1, sell day 4: 3 profit
    # (if you could transact multiple times per day:)
        # Buy day 1, sell day 2: 1
        # Buy day 2, sell day 3: 1
        # Buy day 3, sell day 4: 1 (total 3)
# Essentially then what I'm doing is looking for the combination of sub-arrays which
# have the greatest lowest-to-highest difference.
# Possible combinations in: [1,7,3,7,8,4,9,4,1,3,6,8,3,4,8]
    # [1,7], [3,7,8], [4,9], (ignore 4), [1,3,6,8], [3,4,8]
# What this tells me: It is sufficient to alter my previous pseudo-code to have
# one additional boolean condition on the sell logic:
    # Iterate through each element in the array:
        # If none bought:
            # Is the next element nil? If so, take no action
            # Is the current element less than the next? 
                # If so, buy
                # if not, no action
        # If stock has been purchased:
            # Is the current element greater than previous purchase price? *AND greater than the next?*
                # If so, sell
                # If not, no action


class ProfitFinder
    def max_profit(stock_prices)
        purchased = nil
        total_profit = 0
        stock_prices.each_with_index do |price, index|
            if purchased
                if price > purchased
                    total_profit += price - purchased
                    purchased = nil
                end
            else
                if stock_prices[index + 1] && stock_prices[index + 1] > price
                    purchased = price
                end
            end
        end
        total_profit
    end
end