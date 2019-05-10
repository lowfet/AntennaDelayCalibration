function thetaEstamation = EDelayLSM(input,output)
%  
%   Copyright lwft，2017.12.25
n=length(input);
phi(n)=0;

% for k=1:n
%     phi(k,1)=input(k);
%     phi(k,2)=1;
% end
% 
% for k=1:n
%     Y(k,1)=output(k);
% end

% thetaEstamation=inv(phi'*phi)*phi'*Y;
thetaEstamation=sum(output-input)/n;

% if isnumeric(x)
%     x = x(:);
%     x = x(~isnan(x));
%     xid = [];
% else
%     [x,xid] = grp2idx(x);
%     x = x(~isnan(x));
% end
% x = sort(x(:));    % 排序
% m = length(x);
% x1 = diff(x);    % 求差分
% x1(end + 1) = 1;
% x1 = find(x1);
% CumFreq = x1/m;
% value = x(x1);
% x1 = [0; x1];
% Freq1 = diff(x1);
% Freq2 = Freq1/m;
% if  nargout == 0
%     if isempty(xid)
%         fmt1 = 's   %8s   %6s    %6sn';
%         fmt2 = '  d     ?     %6.2f%%     %6.2f%%n';
%         fprintf(1, fmt1, '取值', '频数', '频率', '累积频率');
%         fprintf(1, fmt2, [value'; Freq1'; 100*Freq2'; 100*CumFreq']);
%     else
%         head = {'取值', '频数', '频率(%)', '累积频率(%)'};
%         [head;xid,num2cell([Freq1, 100*Freq2, 100*CumFreq])]
%     end
% else
%     if isempty(xid)
%         result = [value Freq1 Freq2 CumFreq];
%     else
%         result = [xid,num2cell([Freq1, Freq2, CumFreq])];
%     end
% end