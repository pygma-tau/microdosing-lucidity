---
title: Elements of Information Theory
---

*by Thomas Cover*

# Chapter 1 - Introduction and Preview

> Information theory answers two fundamental questions in communication theory: what is the ultimate data compression (answer: the entropy H), and what is the ultimate transmission rate of communication (answer: the channel capacity C).

Notes:

- The Kolmogorov complexity $K$ is approximately the Shannon entropy $H$ if the sequence is drawn at random from a distribution that has entropy $H.$ (Proof?)
    - Kolmogorov complexity is to complexity minimization as computational complexity is to runtime minimization

# Chapter 2 - Entropy, Relative Entropy, and Mutual Information

The entropy $H(X)$ (or $H(p)$) of a discrete random variable $X$ is defined as 
$$H(X) = - \sum_{x \in \mathcal{X}} p(x) \log p(x),$$
where $\mathcal{X}$ is the alphabet of $X$ and $p(x) = \mathbb{P}(X = x), \, x \in \mathcal{X}.$ Typically the log is taken in base 2, and entropy is measured in bits---if taken in base $e$, then entropy is measured in *nats.* A different interpretation of entropy is as the expected value of $1 / \log p(X),$ such that
$$ H(X) = \mathbb{E}_{p} \left( \log \frac{1}{p(X)} \right). $$ 
This has more connections with entropy in e.g. thermodynamics, and has the following consequences:

- $H(X) \geq 0,$ because $0 \leq p(x) \leq 1$ implies $\log 1/p(X) \geq 0.$ 
- $H_b(X) = (\log_b a) H_a(X),$ because $\log_b p = \log_b a \cdot \log_a p.$ 


The joint entropy $H(X,Y)$ of discrete random variables $(X,Y)$ with some joint distribution $p(x,y)$ is 
$$H(X,Y) = - \sum_{x \in \mathcal{X}} \sum_{y \in \mathcal{Y}} p(x,y) \log p(x,y),$$ which is identical to $$H(X,Y) = -\mathbb{E} \log p(X,Y).$$
The conditional entropy $H(Y|X)$ is $$H(Y|X) =$$

## Problems

**1.** $H(X) = - \sum_{x \in \mathcal{X}} p(x) \log p(x).$ When flipping a coin, the sum becomes

$$\frac{1}{2} \log \frac{1}{2} + \frac{1}{4} \log \frac{1}{4}...$$

which is just

$$\frac{1}{2} \log \frac{1}{2} + \frac{2}{4} \log \frac{1}{2} + \frac{3}{8} \cdot \log \frac{1}{2}...$$

which means that 

$$H(X) = - \log \frac{1}{2} \cdot \frac{1/2}{(1-1/2)^2} = - 2 \log \frac{1}{2} = \boxed{2 \text{ bits}}?$$

**2.** For (a), I assume $H(Y) > H(X),$ and for (b) I assume $H(Y) < H(X)?$ 


