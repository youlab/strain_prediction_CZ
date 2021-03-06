function [sens, spec, acc] = resistance_card(drug)
%FUNCTION: returns the sensitivity, specificity, and accuracy of the 
%          resistance prediction using the CARD database
% INPUT:
%   drug - which drug to report CARD prediction for
%           OPTIONS: 1 - SAM
%                    2 - GM
%                    3 - SXT
%                    4 - CIP
%
% OUTPUT: metrics for resistance prediction
%   sens - sensitivity
%   spec - specificity
%   acc - accuracy

t = readtable('Card_results20181128_FINAL.xlsx');

vars = {'fluoroquinoloneAntibiotic', 'aminoglycosideAntibiotic', 'sulfonamideAntibiotic', 'TEMBeta_lactamase', 'CMYBeta_lactamase', 'CTX_MBeta_lactamase', 'SHVBeta_lactamase', 'ampC_typeBeta_lactamase'};
t2 = t{:,vars};
t2(isnan(t2)) = 0;
t{:,vars} = t2;

strains = t{:, 1};

load('actual_drug_profile.mat')%SAM, GM, SXT, CIP

%check that strains are same
sNames_p = strrep(sNames_phenotypic, ' ', '');
sNames_w = strrep(strains, ' ', '');
setdiff(sNames_p, sNames_w)
all_strains = [sNames_p sNames_w];
for i = 1:244
    cmp = strcmp(all_strains(i, 1), all_strains(i, 2));
    if(cmp == 0)
       disp(i) 
    end
end

wgs_prediction_resfinder = [t{:, 5}+t{:, 6}+t{:, 7}+t{:, 8}+t{:, 9} t{:,3}, t{:,4}, t{:,2}];%SAM, GM, SXT, CIP
threshold = 1;
wgs_prediction_resfinder(wgs_prediction_resfinder > 1) = 1;

predictedProfile = wgs_prediction_resfinder;
%drugProfile: SAM, GM, SXT, CIP

comb = drugProfile + predictedProfile;
minus = drugProfile - predictedProfile;

oneTP = sum(comb(:, drug) == 2);
oneTN = sum(comb(:, drug) == 0);
oneFP = sum(minus(:, drug) == -1);
oneFN = sum(minus(:, drug) == 1);

sens = oneTP/sum(drugProfile(:, drug) == 1);
spec = oneTN/sum(drugProfile(:, drug) == 0);
acc = (oneTP+oneTN)/length(sNames_phenotypic);


end

