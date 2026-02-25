<!DOCTYPE html>
<html>
<head>
    <title>Напоминание о практике</title>
    <style>
        body { font-family: 'Inter', sans-serif; background: #f3efe8; padding: 2rem; }
        .card { background: white; border-radius: 2rem; padding: 2rem; max-width: 600px; margin: 0 auto; }
        h1 { color: #2e3b32; font-size: 1.8rem; }
        p { color: #5e6b53; line-height: 1.6; }
        .button { 
            display: inline-block; 
            background: #7f9a6b; 
            color: white; 
            padding: 0.8rem 2rem; 
            border-radius: 3rem; 
            text-decoration: none;
            margin-top: 1.5rem;
        }
    </style>
</head>
<body>
    <div class="card">
        <h1>{{ $practice->name }}</h1>
        <p>Пришло время для твоей практики!</p>
        @if($practice->goal_value && $practice->goal_unit)
            <p>Цель: {{ $practice->goal_value }} {{ $practice->goal_unit }}</p>
        @endif
        <a href="{{ url('/app/profile.html') }}" class="button">перейти к практике</a>
        <p style="margin-top: 2rem; font-size:0.8rem; color:#aaa;">
            каждый день  шаг на пути
        </p>
    </div>
</body>
</html>
