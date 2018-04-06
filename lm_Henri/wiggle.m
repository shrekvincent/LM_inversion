function wiggle(x,t,Data,style,dmax,showmax,plImage,imageax,example_plot);

if (nargin==9);
    np=3;
    subplot(np,np,1); wiggle(Data);
    subplot(np,np,2); wiggle(Data,dmax);
    subplot(np,np,3); wiggle(x,t,Data);
    subplot(np,np,4); wiggle(x,t,Data,style,dmax);
    subplot(np,np,5); wiggle(x,t,Data,style,dmax,showmax);
    subplot(np,np,6); wiggle(x,t,Data,style,dmax,showmax,plImage);
    if isempty(dmax),
        dmax=max(abs(Data(:)));
    end
    subplot(np,np,7); wiggle1(x,t,Data,style,dmax,showmax,plImage,dmax./10);
    return
end
showmax_def=100;
style_def='wiggle';
if nargin==1,
    Data=x;
    t=[1:1:size(Data,1)];
    x=[1:1:size(Data,2)];
    dmax=max(Data(:));
    style=style_def;
    showmax=showmax_def;
end
if nargin==2,
    Data=x;
    dmax=t;
    t=[1:1:size(Data,1)];
    x=[1:1:size(Data,2)];
    style=style_def;
    showmax=showmax_def;
end
if nargin==3,
    style=style_def;
    dmax=max(abs(Data(:)));
    showmax=showmax_def;
end
if nargin==4,
    dmax=max(abs(Data(:)));
    showmax=showmax_def;
end
if nargin==5,
    showmax=showmax_def;
end
if nargin<7
    plImage=0;
end
if isempty(dmax),
    % Set scaling factor dmax if empty
    dmax=max(abs(Data(:)));
end
if isempty(showmax),
    showmax=100;
end
if nargin==7,
    imageax=[-1 1].*dmax;
end
if plImage==1,
    imagesc(x,t,Data);
    if (length(imageax)==1)
        imageax=[-1 1].*abs(imageax);
    end
    caxis(imageax);
    hold on
end
if (showmax>0)
    if length(x)>1, dx=x(2)-x(1); end
    ntraces=length(x);
    d=ntraces/showmax;
    if d<=1; d=1; end
    d=round(d);
    dmax=dmax/d;
    LineWidth=0.0001;
    EdgeColor=[0 0 0];
    for i=1:d:length(x)
        xt=dx*Data(:,i)'./dmax;
        if (strmatch('VA',style)==1)
            xt1=xt;xt1(find(xt1>0))=0;
            f1=fill(x(i)+[xt,fliplr(xt1)],[t,fliplr(t)],[0 0 0]);
            set(f1,'LineWidth',LineWidth)
            set(f1,'EdgeColor',EdgeColor)
            %set(f1,'EdgeAlpha',[0]); % GIVES ROCKY IMAGES
            hold on
            if (strmatch('VA2',style,'exact')==1)
                xt2=xt;xt2(find(xt2<0))=0;
                f2=fill(x(i)+[xt,fliplr(xt2)],[t,fliplr(t)],[1 0 0]);
                set(f2,'LineWidth',LineWidth)
                set(f2,'EdgeColor',EdgeColor)
                %set(f2,'EdgeAlpha',[0])
            end
        else
            plot(xt+x(i),t,'k-','linewidth',.05);
        end
        if i==1, hold on;end
    end
end
hold off;
try
    axis([min(x)-(x(2)-x(1)) max(x)+(x(2)-x(1)) min(t) max(t)])
catch
    axis([min(x) max(x) min(t) max(t)])
end
set(gca,'Ydir','revers')
