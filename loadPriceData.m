function loadPriceData(priceScenario)        
      
        priceTable = readtable('simulation/data/price/price-data.csv');     
        switch(priceScenario)
            case 'winter-high'
                hourlyPrice = priceTable.Winter_HighPrice;                
            case 'winter-low'
                hourlyPrice = priceTable.Winter_LowPrice;  
            case 'spring-high'
                hourlyPrice = priceTable.Spring_HighPrice;                  
            case 'spring-low'
                hourlyPrice = priceTable.Spring_LowPrice;              
            case 'summer-high'
                hourlyPrice = priceTable.Summer_HighPrice;                  
            case 'summer-low'
                hourlyPrice = priceTable.Summer_LowPrice;                   
            case 'fall-low'
                hourlyPrice = priceTable.Fall_LowPrice;                   
             case 'fall-high'
                hourlyPrice = priceTable.Fall_HighPrice;    

        end
        
        [sortedPrice,indexes] = sort(hourlyPrice);
        hijackedPrice = hourlyPrice;

        for ii=1:1:6
            hijackedPrice(indexes(ii)) = hourlyPrice(indexes(25-ii));
            hijackedPrice(indexes(25-ii)) = hourlyPrice(indexes(ii));
        end

        for ii=1:1:1440
            minutePrice(ii) = round(hourlyPrice(ceil(ii/60)) / 60, 3);
        end

       for ii=1:1:1440
            hijackedMinutePrice(ii) = round(hijackedPrice(ceil(ii/60)) / 60, 3);
        end

        plot(hijackedPrice,'r--*');    
        hold on;
        grid on;
        plot(hourlyPrice,'b--o')  
        xlabel('Time (Hours)')
        ylabel('Price (¢)')
        title('Normal Pricing VS Hijacked Pricing Data')
        legend('Hijacked Hourly Price Data','Original Price Data')

        figure
        plot(hijackedMinutePrice,'r--*');    
        hold on;
        grid on;
        plot(minutePrice,'b--o')  
        xlabel('Time (Hours)')
        ylabel('Price (¢)')
        title('Normal Pricing VS Hijacked Pricing Data (In Minutes)')
        legend('Hijacked Hourly Price Data','Original Price Data')

        assignin('base','hijackedMinutePrice',hijackedMinutePrice);
        assignin('base','minutePrice', minutePrice);
end