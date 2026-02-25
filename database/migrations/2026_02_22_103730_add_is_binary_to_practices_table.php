<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{


public function up(): void
{
    Schema::table('practices', function (Blueprint $table) {
        $table->boolean('is_binary')->default(false)->after('goal_days');
    });
}

public function down(): void
{
    Schema::table('practices', function (Blueprint $table) {
        $table->dropColumn('is_binary');
    });
}



};
