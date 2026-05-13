# O Impacto da IA, Produtividade, Renda e Pessoas
> 🇺🇸 **Looking for English?** [Click here for the English version](./README.md).

<br>

![Main Dashboard](images/dashboard-preview.png)



## 📌 Descrição do Projeto
<br>
Este projeto analisa como a adoção da Inteligência Artificial está transformando o mercado de trabalho, com foco em produtividade, remuneração e satisfação dos colaboradores.

A análise utiliza dados reais para identificar padrões de automação e ganhos de eficiência em diferentes setores industriais.

> **Nota sobre os dados:**  
> O dataset utilizado neste projeto foi obtido através do **Kaggle**. Trata-se de uma base de dados sintética desenvolvida especificamente para fins de estudo, permitindo a exploração de cenários analíticos e a criação de projetos de Data Science e Business Intelligence.

---
<br>

## 🛠️ Tecnologias Utilizadas

- **Database:** PostgreSQL (Limpeza, normalização e consultas analíticas)
- **Power BI (Desktop & Service):** Desenvolvimento em formato `.pbip` para controle de versão
- **Power Query (Linguagem M):** Transformação de dados (ETL), tradução de colunas e criação de lógicas condicionais
- **DAX:** Criação de medidas calculadas para análise de produtividade, média salarial e KPIs dinâmicos
- **Documentation:** Markdown & GitHub


---

<br>

## 📂 Modelagem e Estrutura de Dados

O projeto seguiu um fluxo de Engenharia de Dados onde a base bruta foi importada e posteriormente normalizada em tabelas lógicas.

<br>

* ### Base Bruta (`ai_jobs_affected`)

Tabela principal contendo todos os dados importados do CSV original.

| Coluna | Descrição |
| :--- | :--- |
| **employee_id** | Identificador único do funcionário |
| **age** | Idade do colaborador |
| **gender** | Gênero do profissional |
| **education_level** | Nível de escolaridade |
| **industry** | Setor de atuação |
| **job_role** | Cargo ocupado |
| **years_experience** | Anos de experiência profissional |
| **ai_adoption_level** | Nível de integração de IA |
| **automation_risk** | Nível de risco de automação |
| **upskilling_required** | Necessidade de capacitação |
| **salary_before_ai** | Salário antes da IA |
| **salary_after_ai** | Salário após IA |
| **job_status** | Status do emprego |
| **work_hours_per_week** | Jornada semanal |
| **remote_work** | Trabalho remoto |
| **job_satisfaction** | Nível de satisfação |
| **productivity_change_percent** | Variação de produtividade |

---


## ✅ Tabelas Normalizadas

Para otimizar o banco de dados, os dados foram divididos em entidades específicas.

<br>

* ### Tabela `employees`

| Coluna | Descrição |
| :--- | :--- |
| **employee_id** | Identificador (Primary Key) |
| **age** | Idade |
| **gender** | Gênero |
| **education_level** | Escolaridade |

<br>

* ### Tabela `job_info`

| Coluna | Descrição |
| :--- | :--- |
| **employee_id** | Identificador (Foreign Key) |
| **industry** | Setor de atuação |
| **job_role** | Cargo |
| **years_experience** | Experiência profissional |
| **work_hours_per_week** | Horas semanais |
| **remote_work** | Regime de trabalho |

<br>

* ### Tabela `ai_impact`

| Coluna | Descrição |
| :--- | :--- |
| **employee_id** | Identificador (Foreign Key) |
| **ai_adoption_level** | Nível de adoção de IA |
| **automation_risk** | Risco de automação |
| **upskilling_required** | Status de capacitação |
| **salary_before_ai** | Salário antes da IA |
| **salary_after_ai** | Salário após IA |
| **job_status** | Status do emprego |
| **job_satisfaction** | Nível de satisfação |
| **productivity_change_percent** | Mudança de produtividade |
---
<br>

## 🧠 SQL Development Process


* ### Data Structuring and Ingestion (ETL)

Criação da estrutura principal do banco de dados e ingestão do dataset original utilizando `COPY` para alta performance.

```sql
CREATE TABLE ai_jobs_affected (
    employee_id TEXT,
    industry TEXT,
    years_experience INT,
    salary_before_ai INT,
    salary_after_ai INT,
    productivity_change_percent INT
    -- Não coloquei todas as colunas para otimizar espaço.
);

COPY ai_jobs_affected
FROM 'C:\DataSets\ai_job_impact.csv'
DELIMITER ','
CSV HEADER;
```
---


* ### Technical Refinement (Data Cleaning)

Ajuste de tipos de dados para garantir precisão decimal nas análises.

```sql
ALTER TABLE ai_jobs_affected
ALTER COLUMN productivity_change_percent TYPE NUMERIC;
```
---


* ### KPI Exploration and Validation

Validação de métricas analíticas utilizando `JOIN` entre tabelas normalizadas.

```sql
SELECT 
    j.industry,
    AVG(a.productivity_change_percent) AS produtividade
FROM job_info j
JOIN ai_impact a 
    ON j.employee_id = a.employee_id
GROUP BY j.industry
ORDER BY produtividade DESC;
```
---


* ### Career and Productivity Analysis

Análise da relação entre experiência profissional e ganho de produtividade.

```sql
SELECT
    j.years_experience,
    AVG(a.productivity_change_percent) AS produtividade
FROM job_info j
JOIN ai_impact a 
    ON j.employee_id = a.employee_id
GROUP BY j.years_experience
ORDER BY j.years_experience;
```
---


* ### Salary Comparison Before and After AI Adoption

Comparação salarial antes e depois da adoção da Inteligência Artificial.

```sql
SELECT 
    AVG(salary_before_ai) AS before_ai,
    AVG(salary_after_ai) AS after_ai
FROM ai_impact;
```
---


* ### Employee Satisfaction by Automation Risk

Análise da satisfação dos colaboradores em relação ao risco de automação.

```sql
SELECT 
    automation_risk,
    AVG(job_satisfaction) AS satisfacao
FROM ai_impact
GROUP BY automation_risk;
```
---
<br>

## ⚡ Power Query (Linguagem M)

Também realizei alguns ajustes com M no Power Query

- Realizei a tradução completa dos filtros e nomes de colunas de inglês para português para garantir a consistência do projeto.
- Refatorei a coluna original "Necessita treinamento" para uma lógica positiva de "Possui treinamento", facilitando a leitura executiva do dashboard.
- Tratamento de erros de sensibilidade de caixa (case sensitivity) que surgiram após as etapas de tradução.

---
<br>

## 📊 Inteligência Analítica (DAX)


Desenvolvi medidas para transformar dados brutos em indicadores estratégicos (KPIs).

- Cálculo da variação percentual e absoluta entre os salários antes e depois da implementação da IA.
- Medidas dinâmicas para calcular a média de produtividade segmentada por indústria e nível de adoção tecnológica.
- Métricas para correlacionar o risco de automação com o índice de satisfação dos colaboradores.

---
<br>

## 🎯 Business Problem

A Inteligência Artificial está transformando indústrias e mudando a forma como os profissionais trabalham.

Este projeto busca responder perguntas estratégicas como:

- A adoção da IA aumenta a produtividade?
- Como a IA impacta os salários?
- Quais setores mais se beneficiam?
- Existe relação entre automação e satisfação?
- A experiência profissional influencia os ganhos de produtividade?

---
<br>

## 📊 Dashboard Preview

O dashboard oferece uma visão executiva das métricas de impacto da IA.

![Dashboard Zoom](Images/Charts/dash-zoom.png)

- KPIs de produtividade
- Evolução salarial
- Análise de automação
- Correlação entre satisfação e risco
- Filtros interativos
- Comparações setoriais
---
<br>

## 💡 Resultados e Direcionamentos Estratégicos

 Nesta seção, as perguntas fundamentais de negócio são respondidas através da interpretação analítica das visualizações contidas no dashboard.

* **A adoção da IA aumenta a produtividade dos funcionários?**

Sim. Observamos um ganho médio real de **9,79%** na produtividade global.

A análise setorial revela que este ganho é ainda mais acentuado na **Indústria**, ultrapassando os **11%**, posicionando a IA como acelerador crítico de performance.

---

* **Como a IA impacta os salários?**


A tecnologia atua como catalisador de valorização salarial, gerando um aumento médio de **6,07%**.

Profissionais em ambientes de alta adoção tecnológica alcançaram remunerações superiores a **160 mil**, acima da tendência média de mercado.

---

* **Quais indústrias mais se beneficiam da IA?**

**Indústria e Marketing** lideram os ganhos de produtividade.

Isso sugere que setores com processos padronizados ou forte demanda por geração de conteúdo absorvem valor mais rapidamente.

---

* **A IA compromete a satisfação dos colaboradores?**


Os dados apontam estabilidade nos índices de satisfação.

Independentemente do nível de adoção tecnológica, a satisfação permaneceu próxima de **6,02**, indicando adaptação equilibrada.

---

* **Os ganhos de produtividade são constantes ao longo da carreira?**

Não. A análise demonstra comportamento não-linear, com picos e quedas de produtividade em diferentes estágios profissionais.

Isso indica necessidade de estratégias de suporte adaptadas para cada nível de experiência.

---

<br>

## 👨‍💻 Conclusão

- Notei que a insatisfação dos colaboradores muitas vezes não se correlaciona diretamente com a adoção da IA ou o risco de automação. Isso é um sinal claro para o RH: o bem-estar no trabalho provavelmente está ligado a fatores culturais, liderança e segurança psicológica, e não apenas às ferramentas tecnológicas utilizadas.

- Embora o dataset apresente variações sutis, a estabilidade dos dados reforça que a IA não é uma "bala de prata" que muda tudo da noite para o dia, mas sim uma ferramenta de ganho incremental e constante.

- O grande valor deste projeto não está apenas em medir a produtividade, mas em entender onde a intervenção humana (upskilling) é necessária para evitar que a automação se torne um gargalo em vez de um acelerador.


---

>Este projeto foi um exercício de ponta a ponta da estruturação em SQL à narrativa no Power BI.

*Produzido por Nicolas Rheinheimer - Data Analytics & Data Sciency Projects*