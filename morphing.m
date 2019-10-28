function imDst = morph(imSrc, ptSrc, ptDst)

nCtrlPt = length(ptSrc);
Xinv = zeros(size(imSrc,1), size(imSrc,2));
Yinv = zeros(size(imSrc,1), size(imSrc,2));
A = zeros(nCtrlPt+3);
Bx = zeros(nCtrlPt+3, 1);
By = zeros(nCtrlPt+3, 1);

C = zeros(nCtrlPt, 1);
sqdist = zeros(nCtrlPt, 1);
for ki = 1:nCtrlPt % locate nearest point
    X1 = ptDst(ki, 1);
    Y1 = ptDst(ki, 2);
    for kj = 1:nCtrlPt
        X2 = ptDst(kj, 1);
        Y2 = ptDst(kj, 2);
        sqdist(kj) = (X1-X2).^2 + (Y1-Y2).^2;
    end
    sqdist(ki) = inf;
    sqdist(sqdist<5) = inf;
    C(ki) = min(sqdist);
end

for ki = 1:nCtrlPt
    X1 = ptDst(ki, 1);
    Y1 = ptDst(ki, 2);
    for kj = 1:nCtrlPt
        X2 = ptDst(kj, 1);
        Y2 = ptDst(kj, 2);
        A(ki, kj) = 1/sqrt(C(kj)+(X1-X2).^2+(Y1-Y2).^2);
    end
end
end

