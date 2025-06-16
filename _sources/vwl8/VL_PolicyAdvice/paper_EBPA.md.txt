---
toc: true

abstract: |
  What are the effects of sport events and professional sports clubs on a regional economy? Politicians face this question whenever they are lobbied to subsidize sport events, infrastructure and related investments.  Matthias Brachert (2021) addresses this issue by analyzing the short term effects of football club relegations using a quasi \- experimental approach. His innovative use of regression discontinuity design provides a clearer understanding of causal economic effects. This seminar paper introduces and critically analyzes Brachert’s paper using the Scientific Methodological Standards framework by Farrington et al. (2002).

number-sections: true
lang: EN

format:
  pdf: 
    documentclass: scrartcl
    fontsize: "12pt"
    fontfamily: newtxtext
    linestretch: "1.5"
    papersize: a4
    header-includes: |
      \usepackage{fancyhdr}
      \pagestyle{fancy}
      \fancyhf{}
      \fancyhead[R]{\thepage}
      \fancyhead[L]{Evidence Based Policy Advice}
    geometry:
      - top=22.5mm
      - bottom=30mm
      - left=30mm
      - right=25mm
---


{{< pagebreak >}}


# Introduction (Mario)

The seminar for which this paper is written discusses policy advice based on empirical research. Matthias Brachert’s paper (2021) focuses on the question of what the economic effects of professional sports clubs and sporting events on regional economies are? His paper is motivated by an academic debate on the regional economic impact of professional sports, as in Coates (2023). Ex-ante studies often overestimate effects, using forecasts and multipliers, as Brachert explains using Baade & Matheson (2016). The predictions promise substantial gains, particularly in local employment, consumption, and tourism. However, as Brachert continues to explain, a growing body of academic literature has challenged these optimistic projections. Many scientific studies suggest that the effects of professional sports are typically confined to specific sectors and limited geographic areas, and that broader economic gains may be offset by substitution effects — where consumer spending merely shifts from one activity to another.

Within this debate, Matthias Brachert provides a new contribution by empirically investigating the regional economic consequences of football club relegations. Rather than relying on hypothetical forecasts or simulations, he uses real-world relegation events as quasi-natural experiments to identify causal effects. The study employs a regression discontinuity design (RDD) to compare economic outcomes in regions whose clubs experienced relegation with regions where clubs narrowly avoided it. This methodological innovation aims to provide a clearer understanding of short-term, causal economic effects.

The study sets and tests three hypotheses. First (H1), that club income is negatively affected by relegation. Second (H2), that relegation has measurable short-term negative effects on regional sectors closely linked to professional football, such as hospitality and tourism. Third (H3), that relegation negatively affects overall regional economic development, as measured by employment and gross value added (GVA). 

While introducing Brachert’s study, this seminar paper will also evaluate the empirical strategy and the robustness of the results using the lens of the Scientific Methodological Standards (SMS) framework. We are aware of the rules of good scientific writing, which advise a clear separation between presentation and discussion. However, since we did not conduct the research ourselves but rather aim to critically assess Brachert’s work, we find that a compromise on this rule is necessary. In the chapters introducing Brachert’s paper, we will already include some factual elements of our critique where they directly relate to methodological or empirical points. Nevertheless, the overall discussion and synthesis of our critical findings will still be presented in the dedicated discussion chapter.

{{< pagebreak >}}

# Literature (Marten)

The paper is well situated within the broader academic discourse on the economic effects of professional sports franchises. The overview study by Coates and Hamphreys (Coates und Humphreys 2008\) concludes that there is little to no evidence supporting substantial positive economic effects of professional sports teams or stadiums that would warrant public subsidies. On a supraregional level, these effects appear to be largely a zero-sum game.

Empirical studies on the regional economic impact of sports franchises yield mixed but generally modest findings. For instance, Baade and Matheson (2011) report small positive effects from university sports leagues in Florida. In contrast, (Feddersen und Maennig 2012\), studying the 2006 FIFA World Cup in Germany, finds that while the hospitality sector experienced positive short-term effects, the construction sector saw negative impacts. Coates and Humphreys (2011) investigate sports strikes in the NBA and concludes that such disruptions had no significant economic consequences. Similarly, Storm et al. (2017) show that professional sports leagues in Denmark had only very small effects on specific sectors of the economy.

These findings underscore a key economic intuition: consumers operate under a fixed budget for leisure and sports expenditures. When professional football is unavailable or less attractive (e.g., due to relegation), this spending is often reallocated to other activities—a classic case of the substitution effect. As a result, any economic impact tends to be temporally, sectorally, and geographically bounded.

Much of the literature focuses on the supply side of sports economics, assessing how the presence or absence of clubs or events affects local economies. However, the demand side—particularly the inflow of income from extra-regional sources and the marginal propensity to consume locally—also plays a critical role. This dimension is emphasized in the present study, especially in its identification of professional clubs as potential export-base sectors.

{{< pagebreak >}}

# Relegations and RDD design (Mario)

The study by Matthias Brachert (2021) uses the fact that relegations in professional football follow a ranking system. At the end of each season, clubs placed in the lowest positions of the league table are relegated to a lower division. Teams close to the relegation position are usually close in points, which determine their position \- so much so that sometimes another measure like goal difference needs to be applied. This structure led Brachert to use it as a setting for a regression discontinuity design (RDD). The cutoff between treated and untreated units enables a quasi-experimental approach to estimate causal effects.

The basic idea of RDD is to compare units just above and just below a predefined cutoff. The region around the cutoff where this comparison is valid is referred to as the bandwidth. Within the bandwidth, the assumption is that these units are comparable, and that treatment assignment is as good as random. This is not because randomness is observed, but because small differences in the running variable are assumed not to be systematically related to potential outcomes. In the context of professional football, clubs close in points are also assumed to be similar in economic strength, audience appeal, and other relevant factors. The cutoff is determined by league rules — for example, in a 20-team competition, the last three teams are relegated. The treatment group consists of clubs that are relegated; the control group includes those narrowly avoiding relegation. The running variable is the number of points collected during the season.

Brachert emphasizes that point differences near the cutoff are often very small — sometimes below three points — and describes this as introducing an element of randomness into the selection of the treatment group. This interpretation is intended to strengthen the case for comparability, though the assumption of “as-if random” assignment is already built into the RDD design. In addition, Brachert argues that tie-breaking procedures and institutional rules introduce a degree of fuzziness into the assignment mechanism, meaning that treatment is not perfectly determined by a single continuous variable. This suggests a fuzzy RDD setup rather than a sharp one, a point that is acknowledged but not further developed in the paper.

One important assumption for an RDD design is that the cutoff — or more precisely, the positioning around the cutoff — cannot be manipulated. To test this, Brachert applies the McCrary density test, which checks for unusual clustering of the running variable around the cutoff point. While this is a standard diagnostic tool in RDD studies, its applicability in this specific setting may be limited — a point we return to in the discussion section.

Brachert’s study tests three hypotheses regarding the economic consequences of relegation. His identification strategy relies on the assumption that clubs near the relegation cutoff — within a narrow bandwidth of league points — are comparable in all respects except for the treatment, i.e., whether or not they were relegated. Under this assumption, any systematic difference in outcomes between the relegated and non-relegated clubs’ regions within this range can be interpreted as the causal effect of relegation. According to the main text, the analysis is restricted to this bandwidth, which is determined using a data-driven method. However, information in the appendix suggests that larger regional units or observations beyond this immediate range may have been included in some model specifications. While this could reflect an attempt to test the plausibility or robustness of the results — a valid methodological choice in itself — the inconsistency between the narrow-bandwidth design logic and the broader sample scope, even if only partial, raises questions about internal consistency. We consider this an important point of critique, not necessarily affecting the core results, but relevant in terms of methodological transparency and coherence across the paper and its supplementary materials.

The three hypotheses reflect different levels at which such effects might occur. H1 addresses the club itself, testing whether relegation negatively affects club income. H2 examines the impact on economic sectors closely connected to football, such as hospitality and sports services. H3 explores whether there are broader effects on regional economic development, which should show in employment and gross value added (GVA) data.

In the regression discontinuity framework, the effect of relegation is identified by a discontinuity — or “jump” — in the outcome variable at the cutoff. If such a jump is observed in the data, it provides evidence of a treatment effect.

Taken together, the study uses a well-defined, real-world cutoff and a plausible quasi-random assignment mechanism to estimate short-term economic effects of professional football success or failure. While the design, according to Brachert, is not strictly sharp due to the presence of tie-breaking rules, the structure of the football league system still allows for a credible identification strategy. In this regard, Brachert positions his approach as a methodological improvement over earlier studies that relied on simulations or forecast-based projections.

From an SMS (Scientific Methodological Standards) point of view, the RDD design of the study ranks high on the scale of strategies for causal inference. It is considered a quasi-experimental design with strong internal validity. While certain implementation choices raise open questions — which we will address in the discussion — the overall strategy reflects a credible and well-grounded approach to identifying causal effects.

{{< pagebreak >}}

# Data & Results (Marten)

## Data

The study utilizes valid and credible data sources covering the period from 1995 to 2012\. Regional economic indicators are drawn from the Cambridge Econometrics European Regional Database at the NUTS-3 level, offering the most disaggregated regional economic data available for the European context. However, one limitation arises from the sectoral resolution of the data: the analysis is constrained to broad economic categories, particularly sectors G–K (wholesale, retail, transport, accommodation, food services, information, and communication). This limits the precision of the sector-specific interpretation of football-related economic effects.

The analysis spans 16 seasons and covers four major European football leagues: Italy’s Serie A, France’s Ligue 1, Germany’s Bundesliga, and the English Premier League. Attendance data at the club level are sourced from European Football Statistics, a well-known but non-official repository of spectator data. While the website does not disclose its data sources, it compiles information from fan-based and publicly reported figures. Despite its informal nature, the dataset has been widely used in prior academic research (e.g., Buraimo et al (2022)), lending it some degree of scholarly acceptance.

Some methodological challenges emerge from the structure of the data. First, the presence of multiple clubs within a single NUTS-3 region can complicate attribution of regional effects. Second, and more importantly, the treatment assignment in the regression discontinuity design (RDD) varies due to the nature of relegation thresholds. To address this, the author defines treatment dynamically based on the point differential to the first non-relegation rank. A local bandwidth of approximately ±6 points around the cutoff is applied, which is determined through a data-driven procedure using the method from Calonico et al. (2014). This approach enables credible causal inference but results in varying sample sizes and compositions across different model specifications.

## Results

The first hypothesis—that relegation negatively affects the income level of a football club—is empirically confirmed using a regression discontinuity design. The proxy variable employed is average attendance at home games, which shows a significant decline of approximately 28% in the season following relegation. This result is interpreted as a strong indicator of lost revenue and diminished club relevance.

However, the validity of attendance as a proxy for club income is debatable. Detailed financial data at the club level are not available, and attendance figures may not directly correlate with actual income. In the German context, for example, several clubs in the second division (e.g., HSV, Hertha BSC) attract more spectators than some top-division teams (e.g., RB Leipzig), due to historical fan base size and regional significance. This casts doubt on the assumption that relegation uniformly leads to lower match-day income.

Furthermore, the analysis does not differentiate between national contexts, despite the likelihood of differential effects across leagues. Institutional and fan culture differences between Germany, France, Italy, and the UK may influence how relegation impacts attendance and, by extension, revenue. The paper would benefit from a more granular country-level assessment to clarify potential heterogeneity in treatment effects.

Hypothesis 2, which posits a negative effect of relegation on football-related sectors in the regional economy, is confirmed by the analysis. The study finds an average reduction of approximately 3% in gross value added (GVA) within the wholesale, retail, accommodation, and transport sectors of relegated regions. However, the categories used are broad and encompass a wide range of activities not directly tied to football. This aggregation limits the precision of the findings. Moreover, while the results are statistically significant, they are not as robust as those related to attendance, suggesting a weaker but still present sectoral impact.

Hypothesis 3—that relegation affects overall regional development—is only partially supported. The analysis does not detect any significant effect on regional GVA growth. However, a small negative effect on employment is observed, with a p-value of 0.1. This level of statistical significance is weak and suggests only a marginal impact, particularly in the short term examined by the study. Consequently, while relegation appears to influence specific sectors, its broader economic consequences at the regional level remain limited and statistically inconclusive.

The results, while methodologically robust in many respects, exhibit several limitations that affect the interpretability and comparability of its findings. First, the use of a fourth-degree polynomial to visualize the regression discontinuity (RD) cutoff—particularly in figures supporting Hypothesis 2—raises concerns about potential overfitting. As noted by Gelman and Imbens (2019), high-order polynomials can exaggerate discontinuities and introduce misleading curvature, especially in RD contexts. Although these fits are used only for visualization, they may still bias the reader’s perception of treatment effects.

Second, the bandwidth around the cutoff varies across regressions due to the use of the *rdrobust* package, which employs the data-driven procedure outlined in Calonico et al. (2014). While this approach optimizes bandwidth to minimize mean squared error, it also introduces inconsistency: each hypothesis test is estimated on different subsamples, with varying numbers of treated and control units. For instance, the model estimating the change in absolute attendance (Table 3\) uses 74 treated and 299 control observations with a bandwidth of 4.6 points, whereas the relative attendance model includes 101 treated and 397 control observations within a 6.3-point bandwidth. This variation leads to inconsistent sample sizes and potentially limits the comparability of results across hypotheses.

In sum, while the paper applies appropriate and widely accepted RD techniques, the combination of visual overfitting and inconsistent sample definitions across tests calls for cautious interpretation. Greater transparency in modeling choices and robustness checks using fixed or common bandwidths could strengthen the reliability and comparability of the reported effects.

## Classification on the Maryland Scale

Taken together, the study applies a well-established quasi-experimental approach that offers high internal validity and is widely accepted in applied econometrics. According to the Maryland Scientific Methods Scale (SMS), which was recommended as an assessment framework for this seminar, the regression discontinuity design qualifies as a Level 4 strategy — just one step below randomized controlled trials. This classification reflects the use of a sharp, exogenous cutoff and a credible identification mechanism, which support the study’s causal claims.

While certain aspects of the implementation—such as varying bandwidths, limited detail in model equations, and the absence of publicly shared data or code—raise valid concerns about transparency and consistency, these do not fundamentally undermine the identification strategy. As long as these limitations remain within acceptable bounds of methodological rigor, they do not affect the SMS classification of the study as Level 4\.

{{< pagebreak >}}

# Discussion and Critical Reflections

## Introduction: A Constructive Evaluation (Marten)

Beyond its methodological strength, the study makes a substantive contribution to the literature on the economic effects of professional sports franchises. It introduces the innovative idea of using relegation thresholds as a natural experiment and provides new evidence on the consequences of relegation. The findings confirm existing research: economic effects are largely sectoral, short-term, and geographically limited. Policymakers should take note of these findings, but they do not justify major concern or policy intervention.

In particular, the study casts doubt on the rationale for public subsidization of professional sports clubs, especially in cases where public resources are used without clear economic returns—for example, the provision of free policing at stadiums in Germany, despite significant public costs. This debate has been critically discussed, e.g., by Mause (Mause 2020\). While the study’s empirical framework is not without weaknesses—such as data limitations and sample inconsistencies—it nonetheless offers a novel and well-founded contribution to the evidence base on sports and regional policy.

## Internal Consistency: Region Selection and Sample Scope (Mario)

As discussed in Chapter 2, the main text of the paper emphasizes a narrow bandwidth design, consistent with RDD methodology. However, the supplementary materials suggest a possible inclusion of broader regional units, raising concerns about internal consistency. While this may reflect a robustness check rather than a departure from the core design, the lack of explicit clarification weakens the transparency of the study. We consider this an important point of critique — not one that undermines the results, but one that undermines the overall consistency of the paper.

## Visual Specification and Diagnostic Validity (Mario)

The use of binning and varying bandwidths in the visual presentation of the results was discussed in detail in Chapter 3\. We refer to that assessment and simply conclude here that while the graphical choices do not invalidate the study’s results, they should be treated with caution, especially regarding interpretability and comparability across hypotheses.

Beyond this, a deeper technical issue lies in the construction and interpretation of the running variable. In Brachert’s setup, league points function as the running variable that determines treatment (relegation). However, the number of points needed to avoid relegation varies by season, depending on the distribution of points and performance of other teams. This means the cutoff is not fixed across observations but moves from season to season. While this is manageable for the estimation strategy — since the cutoff is well-defined within each season — it weakens the idea of a universal threshold toward which manipulation could occur.

This becomes particularly relevant in the use of the McCrary density test, which checks for abnormal clustering around the cutoff. The logic of the test depends on units being able to manipulate their position relative to a stable threshold. In Brachert’s case, however, there is no such stable value: the number of points required to avoid relegation differs each year and is only known at the end of the season. Furthermore, if the running variable were understood as team rank (rather than points), the variable would be ordinal and mutually exclusive — rendering the density test meaningless by construction.

Thus, while the McCrary test is technically implemented, its interpretive value in this context is questionable. It serves more as a formal adherence to standard RDD diagnostics than as a substantively informative check. This illustrates the risk of applying default tools without fully considering their contextual fit. That said, this is a technical critique, not a substantive one: it does not call into question the overall validity of the results but highlights a mismatch between method and empirical setting.

## Economic Interpretation: Export, Import, and Leakage Effects (Mario)

One of the Central mechanisms for explaining economic effects of sport events is the export effect. Brachert cites several sources discussing this topic. While Baade & Matheson (2016) discuss the export effect, they take a more skeptical stance on its importance. Roberts et al. (2016) on the other hand discuss this more in the context of an offsetting effect of regional in and out flows. Brachert’s study seems to focus on the export effect in seeking explanations for economic effects. The export effect is the idea that football clubs attract external demand to their regions — through visiting fans, media attention, and other football-related consumption — and that this demand declines following relegation. Brachert argues that this loss of external demand has a measurable effect on the sports-related sectors of a region, such as hospitality, catering, and entertainment. 

While this mechanism is plausible and in part supported by the literature, it is criticized by Baade & Matheson. It also raises the question of an “import effect”. Brachert’s framing assumes that demand from external visitors is a net gain to the region, but it remains unclear whether this inflow exceeds the corresponding outflows over a season. In terms of outflows, he explains leakage as a possible explanation for why income generated in the region may not remain there — for example, when clubs and players spend excessive income in other regions. However, there is also a more direct “import effect” meaning residents of the region spending money while visiting away games. Roberts et al. discuss import and export effects as cancelling each other out. Brachert cites this literature, but the arguments are not integrated into his argumentation. Since this is more a discussion of reasonable economic explanations, it does not really affect the empirical investigation. Brachert himself seems to be aware of this discrepancy when suggesting the inclusion of tourism data in future research. 

As a result, export effects might be overstated as a possible explanation. If relegation reduces both inflows and outflows, the net change might be smaller than assumed — or even balanced. Potentially leaving the author without an explanation for the effects found in the study. It emphasizes that statements about import/export effects might seem obvious on a surface view, but require data to verify them. 

## Concluding Remark (Mario & Marten)

The paper employs an innovative use of a regression discontinuity design, reaching a high level on the SMS scale while delivering empirically solid and valid results on a policy-relevant economic question. While we consider our critical points to be justified, they are made in the context of practicing critical evaluation as part of this seminar paper and do not, in our view, diminish the overall quality or credibility of the study.

{{< pagebreak >}}

# Bibliography

Baade, Robert A., and Victor A. Matheson. ‘Going for the Gold: The Economics of the Olympics’. *Journal of Economic Perspectives* 30, no. 2 (May 2016): 201–18. [https://doi.org/10.1257/jep.30.2.201](https://doi.org/10.1257/jep.30.2.201).

Baade, Robert A., Baumann ,Robert W., and Victor A. and Matheson. ‘Big Men on Campus: Estimating the Economic Impact of College Sports on Local Economies’. *Regional Studies* 45, no. 3 (1 March 2011): 371–80. [https://doi.org/10.1080/00343400903241519](https://doi.org/10.1080/00343400903241519).

Brachert, Matthias. 2021\. „Regional effects of professional sports franchises: causal evidence from four European football leagues“. *Regional Studies* 55 (2): 295–306. [https://doi.org/10.1080/00343404.2020.1759794](https://doi.org/10.1080/00343404.2020.1759794).

Buraimo, Babatunde, Giuseppe Migali, and Rob Simmons. ‘Impacts of the Great Recession on Sport: Evidence from English Football League Attendance Demand’. *Oxford Economic Papers* 74, no. 1 (1 January 2022): 155–77. [https://doi.org/10.1093/oep/gpaa055](https://doi.org/10.1093/oep/gpaa055).

Calonico, Sebastian, Matias D. Cattaneo, and Rocío Titiunik. ‘Robust Data-Driven Inference in the Regression-Discontinuity Design’. *The Stata Journal: Promoting Communications on Statistics and Stata* 14, no. 4 (December 2014): 909–46. [https://doi.org/10.1177/1536867X1401400413](https://doi.org/10.1177/1536867X1401400413).

Coates, Dennis. ‘Growth Effects of Sports Franchises, Stadiums, and Arenas: 15 Years Later’. In *The Economic Impact of Sports Facilities, Franchises, and Events: Contributions in Honor of Robert Baade*, edited by Victor A. Matheson and Robert Baumann, 59–87. Cham: Springer International Publishing, 2023\. [https://doi.org/10.1007/978-3-031-39248-1\_5](https://doi.org/10.1007/978-3-031-39248-1_5).

Coates, Dennis, and Brad R Humphreys. ‘Do Economists Reach a Conclusion on Subsidies for Sports Franchises, Stadiums, and Mega-Events?’ *Econ Journal Watch*, 2008\.[https://econjwatch.org/articles/do-economists-reach-a-conclusion-on-subsidies-for-sports-franchises-stadiums-and-mega-events](https://econjwatch.org/articles/do-economists-reach-a-conclusion-on-subsidies-for-sports-franchises-stadiums-and-mega-events)

Coates, Dennis, and Brad R. Humphreys. ‘The Economic Consequences of Professional Sports Strikes and Lockouts’. *Southern Economic Journal* 67, no. 3 (2001): 737–47. [https://doi.org/10.2307/1061462](https://doi.org/10.2307/1061462).

Farrington, David P., Denise C. Gottfredson, Lawrence W. Sherman, and Brandon C. Welsh. ‘The Maryland Scientific Methods Scale’. In *Evidence-Based Crime Prevention*. Routledge, 2002\. ISBN: 9780203166697

Feddersen, Arne, and Wolfgang Maennig. ‘Sectoral Labour Market Effects of the 2006 FIFA World Cup’. *Labour Economics* 19, no. 6 (1 December 2012): 860–69. [https://doi.org/10.1016/j.labeco.2012.07.006](https://doi.org/10.1016/j.labeco.2012.07.006).

Gelman, Andrew, and Guido Imbens. ‘Why High-Order Polynomials Should Not Be Used in Regression Discontinuity Designs’. *Journal of Business & Economic Statistics*, 3 July 2019\. [https://www.tandfonline.com/doi/abs/10.1080/07350015.2017.1366909](https://www.tandfonline.com/doi/abs/10.1080/07350015.2017.1366909).

Mause, Karsten. ‘Fußballspiele, Polizeieinsätze und Steuerzahler: Ökonomische Anmerkungen zur Polizeikosten-Debatte’. *List Forum für Wirtschafts- und Finanzpolitik* 45, no. 4 (1 May 2020): 423–40. [https://doi.org/10.1007/s41025-020-00190-4](https://doi.org/10.1007/s41025-020-00190-4).

Storm, Rasmus K., Frederik Thomas, and Tor Georg Jakobsen. ‘Do They Make a Difference? Professional Team Sports Clubs’ Effects on Migration and Local Growth: Evidence from Denmark’. *Sport Management Review* 20, no. 3 (1 July 2017): 285–95. [https://doi.org/10.1016/j.smr.2016.09.003](https://doi.org/10.1016/j.smr.2016.09.003).

{{< pagebreak >}}

# Statement of Authorship

We hereby declare that this work has been composed by ourselves, unless otherwise acknowledged in the text. All points – literally or analogous – taken from published and unpublished sources are identified as such.

A separate declaration on the usage of AI is included in the final submission.

This work has not been submitted in identical or similar form as an examination paper.

We are aware that the failure to acknowledge all used sources amounts to plagiarism and will result in failing this paper (zero points). With my signature we certify that we fully understand the paragraph above.


\
\

Marten Walk, Halle 30.05.25

\
\

Mario Fischer, Halle 30.05.25
