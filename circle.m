function h=circle(r,x0,y0,C,Nb)

if nargin<1, r=[]; end;
if nargin==2, error('Not enough arguments');end;
if nargin<3, x0=[]; y0=[]; end;
if nargin<4, C=[]; end;
if nargin<5, Nb=[]; end
if isempty(r),r=1;end;
if isempty(x0),x0=0;end;
if isempty(y0),y0=0;end;
if isempty(Nb),Nb=300;end;
if isempty(C),C=get(gca,'colororder');end;
x0=x0(:);
y0=y0(:);
r=r(:);
Nb=Nb(:);
if isstr(C),C=C(:);end;
if length(x0)~=length(y0), error('length(x0)~=length(y0)');end;
if length(r)~=length(x0)
maxk=length(r)*length(x0);
else
maxk=length(r);
end;
% 
for k=1:maxk
if length(x0)==1
xpos=x0;
ypos=y0;
rad=r(k);
elseif length(r)==1
xpos=x0(k);
ypos=y0(k);
rad=r;
elseif length(x0)==length(r)
xpos=x0(k);
ypos=y0(k);
rad=r(k);
else
rad=r(fix((k-1)/size(x0,1))+1);
xpos=x0(rem(k-1,size(x0,1))+1);
ypos=y0(rem(k-1,size(y0,1))+1);
end;
the=linspace(0,2*pi,Nb(rem(k-1,size(Nb,1))+1,:)+1);
h(k)=line(rad*cos(the)+xpos,rad*sin(the)+ypos);
set(h(k),'color',C(rem(k-1,size(C,1))+1,:));
end;
% 